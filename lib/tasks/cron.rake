desc "This task is called by the Heroku cron add-on"
task :cron => :environment do
 if Time.now.wday == 1 # run every monday
   puts "Updating box office..."
   BoxOfficeFilm.update
   puts "done."

   puts "Updating retail..."
   BoxOfficeFilm.update_retail
   puts "done."
 end
end