class Movie < ActiveRecord::Base
  has_many :users, :through => :users_movies
  has_many :users_movies, :dependent => :destroy

  validates_presence_of :title
  validates_presence_of :format

  FORMATS = ['Blu-ray', 'DVD', 'HD-DVD', 'LaserDisc', 'VHS Tape']
  RATINGS = [nil, 1, 2, 3, 4, 5]


  def self.search_titles_on_amazon(title, limit = 5)
    is = Amazon::AWS::ItemSearch.new('Video', { 'Title' => title })
    rg = Amazon::AWS::ResponseGroup.new('Medium')

    req = Amazon::AWS::Search::Request.new

    results = []

    begin
      resp = req.search(is, rg, 1)
    rescue Amazon::AmazonError => e
      return results
    end

    items =  resp.item_search_response.items.item

    if items
        items.each do |item|
          # skip search result with no images
          next if item.image_sets.nil?
          attributes = {}

          if item.image_sets.image_set.respond_to?('thumbnail_image')
            thumbnail = item.image_sets.image_set.thumbnail_image.url.to_s
          elsif item.image_sets.image_set.respond_to?('tiny_image')
            thumbnail = item.image_sets.image_set.tiny_image.url.to_s
          else
            thumbnail = item.small_image.url.to_s
          end

          attributes[:thumbnail] = thumbnail
          attributes[:upc]       = item.item_attributes.upc.to_s
          attributes[:image]     = item.medium_image.url.to_s
          attributes[:title]     = item.item_attributes.title.to_s
          attributes[:format]    = item.item_attributes[0].binding.to_s || item.item_attributes.product_group.to_s

          # logger.debug(attributes)
          results << attributes
        end
    end

    results
  end

  def self.lookup_on_amazon(upc)
    lookup_attributes = {'ItemId' => upc, 'SearchIndex' => 'Video'}

    il = Amazon::AWS::ItemLookup.new('UPC', lookup_attributes)
    rg = Amazon::AWS::ResponseGroup.new('Medium')
    req = Amazon::AWS::Search::Request.new

    begin
      resp = req.search(il, rg)
    rescue Amazon::AmazonError => e
      return Hash.new
    end

    items = resp.item_lookup_response.items

    if items && items.item
      item  = items.item
      attributes = {}
      attributes[:asin]         = item.asin.to_s
      attributes[:upc]          = item.item_attributes.upc.to_s
      attributes[:thumbnail]    = item.image_sets.image_set.thumbnail_image.url.to_s
      attributes[:image]        = item.medium_image.url.to_s
      attributes[:image_link]   = item.detail_page_url.to_s
      attributes[:title]        = item.item_attributes.title.to_s
      attributes[:release_date] = item.item_attributes.release_date.to_s
      attributes[:format]       = item.item_attributes[0].binding.to_s || item.item_attributes.product_group.to_s
      return attributes
    end

    Hash.new
  end

  def self.search(search)
    if search
      find(:all, :conditions => ['title LIKE ?', "%#{search}%"])
    else
      find(:all)
    end
  end
end
