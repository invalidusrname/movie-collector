class Movie < ActiveRecord::Base
  belongs_to :user
  belongs_to :borrower, :class_name => "User", :foreign_key => "borrower_id"
  validates_presence_of :title
  validates_presence_of :format

  attr_accessor :upc

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
      item = items.item
      asin  = item.asin.to_s
      img   = item.medium_image.url.to_s
      link  = item.detail_page_url.to_s
      title = item.item_attributes.title.to_s
      type  = item.item_attributes.product_group.to_s
      return {:asin => asin, :link => link, :title => title, :type => type, :img => img}
    end

    Hash.new
  end
end
