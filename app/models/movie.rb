# frozen_string_literal: true

require "amazon/aws/search"

class Movie < ApplicationRecord
  has_many :users, through: :users_movies
  has_many :users_movies, dependent: :destroy
  belongs_to :genre

  FORMATS = ["Blu-ray", "DVD", "HD-DVD", "LaserDisc", "VHS Tape"].freeze
  RATINGS = [nil, 1, 2, 3, 4, 5].freeze

  validates :title, presence: true
  validates :upc, presence: true
  validates :format, inclusion: { in: FORMATS }

  def self.search_titles_on_amazon(title, limit = 5)
    return {} if title.to_s.length < 4

    is = Amazon::AWS::ItemSearch.new("Video", { "Title" => title })
    rg = Amazon::AWS::ResponseGroup.new("Medium")

    req = Amazon::AWS::Search::Request.new(nil, nil, "us")

    results = []

    begin
      resp = req.search(is, rg, 1)
    rescue Exception => e
      logger.debug e
      return results
    end

    logger.debug "#{results.size} found results"

    items = resp.item_search_response.items.item

    items&.each do |item|
      # skip search result with no images
      next if item.image_sets.nil?

      attributes = {}

      thumbnail = if item.image_sets.image_set.respond_to?("thumbnail_image")
                    item.image_sets.image_set.thumbnail_image.url.to_s
                  elsif item.image_sets.image_set.respond_to?("tiny_image")
                    item.image_sets.image_set.tiny_image.url.to_s
                  else
                    item.small_image.url.to_s
                  end

      attributes[:thumbnail] = thumbnail
      attributes[:upc]       = item.item_attributes.upc.to_s
      attributes[:image]     = item.medium_image.url.to_s
      attributes[:title]     = item.item_attributes.title.to_s
      attributes[:format]    = item.item_attributes[0].binding.to_s || item.item_attributes.product_group.to_s

      # logger.debug(attributes)
      results << attributes
    end

    results
  end

  def self.lookup_on_amazon(upc)
    return {} if upc.to_s.length < 4

    lookup_attributes = { "ItemId" => upc, "SearchIndex" => "Video" }

    il = Amazon::AWS::ItemLookup.new("UPC", lookup_attributes)
    rg = Amazon::AWS::ResponseGroup.new("Medium")
    req = Amazon::AWS::Search::Request.new(ENV["AWS_KEY"], ENV["AWS_SECRET"], "us", false)

    begin
      resp = req.search(il, rg)
    rescue Amazon::AmazonError => e
      logger.debug e
      return {}
    end

    items = resp.item_lookup_response.items

    if items&.item
      item = items.item[0]

      attributes = {}
      attributes[:asin]         = item.asin.to_s
      attributes[:upc]          = item.item_attributes.upc.to_s
      attributes[:thumbnail]    = item.image_sets.image_set[0].thumbnail_image.url.to_s unless item.image_sets.nil?
      attributes[:image]        = item.medium_image.url.to_s unless item.medium_image.nil?
      attributes[:image_link]   = item.detail_page_url.to_s
      attributes[:title]        = item.item_attributes.title.to_s
      attributes[:release_date] = item.item_attributes.release_date.to_s
      attributes[:format]       = item.item_attributes[0].binding.to_s || item.item_attributes.product_group.to_s
      return attributes
    end

    {}
  end

  def self.search(search, search_options = {}, options = {})
    if search.to_s.length.positive?
      if search_options.key? :starts_with
        options.merge!(conditions: ["title LIKE ?", "#{search}%"])
      else
        options.merge!(conditions: ["title LIKE ?", "%#{search}%"])
      end
    end
    paginate(:all, options)
  end
end
