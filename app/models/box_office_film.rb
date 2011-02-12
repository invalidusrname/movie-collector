require 'open-uri'

class BoxOfficeFilm < ActiveRecord::Base
  scope :top_films, :conditions => ['position is not null'], :order => :position
  scope :this_week, lambda { {:conditions => ['release_date BETWEEN ? AND ?', Date.today.beginning_of_week, Date.today.end_of_week], :order => 'release_date DESC' } }
  
  
  def self.check_release_info(f, url)
    attributes = {}
    
    if (f.release_date.blank? || f.duration.blank?) && url
      doc = Nokogiri::HTML(open(url))

      line = doc.at("#info ul li[2]")
      if line
        date, duration = line.inner_text.split("|")
        date = date.gsub("Opened|Opens", '').strip
        attributes[:release_date] = Date.parse(date)

        if duration =~ /(\d+)\s+hr\.\s(\d+)\smin\./
          hr = $1.to_i * 60
          min = $2.to_i
          attributes[:duration] = hr + min
        end
      end
    end
    attributes
  end
  
  def self.update
    doc = Nokogiri::HTML(open("http://fandango.com/"))

    BoxOfficeFilm.update_all('position = null AND amount = null', 'position is not NULL OR amount is not null')

    (doc/"#box_office tr").each_with_index do |film, index|
      tds = film/('td')
      if tds && tds.size == 3
        title = tds[0].inner_text.strip

        f = self.find_or_create_by_title(title)

        attributes              = {}
        attributes[:url]        = tds[0].at('a')[:href].strip
        attributes[:amount]     = tds[1].inner_text.strip
        attributes[:ticket_url] = tds[2].at('a')[:href].strip
        attributes[:position]   = index + 1
        attributes.merge!(self.check_release_info(f, attributes[:url]))

        f.update_attributes(attributes)
      end
    end
  end
  
  def self.update_retail
    doc = Nokogiri::HTML(open("http://fandango.com/"))

    list = doc.at("#movieDropDownContents ul.clearfix")

    (list/"li").each do |film|
      if film && film.at('a')
        a     = film.at('a')
        title = a.inner_text.strip
        f = self.find_or_create_by_title(title)

        attributes       = {}
        attributes[:url] = a[:href].strip
        attributes[:ticket_url] = attributes[:url].gsub('movieoverview', 'movietimes')
        attributes.merge!(self.check_release_info(f, attributes[:url]))

        f.update_attributes(attributes)
      end
    end
  end
end
