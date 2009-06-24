class Movie < ActiveRecord::Base
  has_many :users, :through => :users_movies
  has_many :users_movies

  validates_presence_of :title
  validates_presence_of :format

  attr_accessor :upc

  FORMATS = ['Blu-Ray', 'DVD', 'HD-DVD', 'LaserDisc', 'VHS']

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
      attributes[:asin]  = item.asin.to_s
      attributes[:thumbnail] = item.image_sets.image_set.thumbnail_image.url.to_s
      attributes[:image]  = item.medium_image.url.to_s
      attributes[:link]  = item.detail_page_url.to_s
      attributes[:title] = item.item_attributes.title.to_s
      attributes[:release_date] = item.item_attributes.release_date.to_s
      attributes[:type]  = item.item_attributes[0].binding.to_s || item.item_attributes.product_group.to_s
      return attributes
    end

    Hash.new
  end
end
