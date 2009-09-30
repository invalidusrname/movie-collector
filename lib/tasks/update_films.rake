require 'open-uri'
require 'hpricot'

task :box_office => ['box_office:top_films', 'box_office:this_week']

# todo incomplete
desc 'updates movies coming out for purchase this week'
task :retail => :environment do
  
  month = ENV['month'] || Date.today.month
  year = ENV['year']   || Date.today.year
  
  doc = Hpricot(open("http://homevideo.about.com/library/blDVDreleases#{year}.htm"))

  release_date_links = []

  (doc/"#articlebody p font a").each do |element|
    href = element[:href]
    if href =~ /a\.htm$/
      link_date = href.match(//)
      date = Date.today.cweek + 1
      release_date_links << href
    end
  end
end

namespace :box_office do

  desc 'updates top grossing films for the week'
  task :top_films => :environment do
    doc = Hpricot(open("http://fandango.com/"))

    BoxOfficeFilm.update_all('position = null AND amount = null', 'position is not NULL OR amount is not null')

    (doc/"#box_office tr").each_with_index do |film, index|
      tds = film/('td')
      if tds && tds.size == 3
        title = tds[0].inner_text.strip

        f = BoxOfficeFilm.find_or_create_by_title(title)

        attributes              = {}
        attributes[:url]        = tds[0].at('a')[:href].strip
        attributes[:amount]     = tds[1].inner_text.strip
        attributes[:ticket_url] = tds[2].at('a')[:href].strip
        attributes[:position]   = index + 1
        attributes.merge!(check_release_info(f, attributes[:url]))

        f.update_attributes(attributes)
      end
    end
  end

  desc 'updates movies coming out this week'
  task :this_week => :environment do
    doc = Hpricot(open("http://fandango.com/"))

    list = doc.at("#movieDropDownContents ul.clearfix")

    (list/"li").each do |film|
      if film && film.at('a')
        a = film.at('a')
        title                   = a.inner_text.strip

        f = BoxOfficeFilm.find_or_create_by_title(title)

        attributes       = {}
        attributes[:url] = a[:href].strip
        attributes[:ticket_url] = attributes[:url].gsub('movieoverview', 'movietimes')
        attributes.merge!(check_release_info(f, attributes[:url]))

        f.update_attributes(attributes)
      end
    end
  end
  
  def check_release_info(f, url)
    attributes = {}
    if (f.release_date.blank? || f.duration.blank?) && url
      doc = Hpricot(open(url))
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
end