# frozen_string_literal: true

desc "This task is called by the Heroku cron add-on"
task cron: :environment do
  if Time.zone.now.wday == 1 || ENV["FORCE"].to_i == 1 # run every monday
    puts "Updating box office..."
    BoxOfficeFilm.update
    puts "done."

    puts "Updating retail..."
    BoxOfficeFilm.update_retail
    puts "done."
  end
end
