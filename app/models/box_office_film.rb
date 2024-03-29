# frozen_string_literal: true

require "open-uri"

class BoxOfficeFilm < ApplicationRecord
  scope :top_films, -> { where("position is not null").order(:position) }

  def self.this_week
    start_date = Date.today.beginning_of_week
    end_date = Date.today.end_of_week

    where("release_date >= ? AND release_date <= ?", start_date, end_date).order("release_date DESC")
  end

  def self.check_release_info(f, url)
    attributes = {}

    if (f.release_date.blank? || f.duration.blank?) && url
      doc = Nokogiri::HTML(URI(url).open)

      line = doc.at("#info ul li[2]")
      if line
        date, duration = line.inner_text.split("|")
        date = date.gsub("Opened|Opens", "").strip
        attributes[:release_date] = Date.parse(date)

        if duration =~ /(\d+)\s+hr\.\s(\d+)\smin\./
          hr = ::Regexp.last_match(1).to_i * 60
          min = ::Regexp.last_match(2).to_i
          attributes[:duration] = hr + min
        end
      end
    end
    attributes
  end

  def self.update
    doc = page

    BoxOfficeFilm.update_all("position = null, amount = null", "position is not NULL OR amount is not null")

    (doc / "#box_office tr").each_with_index do |film, index|
      tds = film / "td"
      next unless tds && tds.size == 3

      title = tds[0].inner_text.strip

      f = find_or_create_by_title(title)

      attributes              = {}
      attributes[:url]        = tds[0].at("a")[:href].strip
      attributes[:amount]     = tds[1].inner_text.strip.gsub("$", "").gsub("M", "")
      attributes[:ticket_url] = tds[2].at("a")[:href].strip
      attributes[:position]   = index + 1
      attributes.merge!(check_release_info(f, attributes[:url]))

      f.update(attributes)
    end
  end

  def self.page
    Nokogiri::HTML(URI("http://fandango.com/").open)
  end

  def self.update_retail
    doc = page

    list = doc.at("#movieDropDownContents ul.clearfix")

    (list / "li").each do |film|
      next unless film&.at("a")

      a     = film.at("a")
      title = a.inner_text.strip

      f = find_or_create_by_title(title)

      attributes       = {}
      attributes[:url] = a[:href].strip
      attributes[:ticket_url] = attributes[:url].gsub("movieoverview", "movietimes")
      attributes.merge!(check_release_info(f, attributes[:url]))

      f.update(attributes)
    end
  end
end
