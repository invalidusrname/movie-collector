# Movie Collector

Movie Collector gives people the ability to catalog their movies. You can enter film information manually, or simply enter a UPC code and let the app fill out the formation for you. Along with cataloging, you can loan your films out or borrow from another user’s collection. Future enhancements I'd like to include listing movies currently out in the theater and their showtimes, as well as release dates for dvd/blu-ray movies.

That's pretty much it. Make a note, send me an email, or issue a ticket if I've missed anything. Suggestions and improvements are always welcome.

## Requirements

In order to get movie collector running you'll need to install any missing gems. The list of requirements is changing over time, so rather than list an incomplete list, use the following command to install the required gems on your system:

  rake gems:install

Don't forget to adjust the RAILS_ENV variable to install gems for each environment. This'll make sure you only install the gems you need for each environment work in

## Setting up

There's a few settings files that will have to be adjusted. These files are not included, but there are ones with an associated 'sample' extension you can use as a starting point. Adjust the following files as necessary:

- amazonrc.txt     (amazon configuration settings used to lookup and movies)
- config.yml       (application-wide settings. Currently used to for mail settings)
- database.yml     (the same familiar database settings present in most rails apps)

## Deploying

Capistrano is used for deployment. Currently this project deploys to moviecollector.org, but could be changed in the future.
