# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment',  __FILE__)


if Rails.env == "production"
  use Rack::Static, :urls => ["/stylesheets/compiled"], :root => "tmp" #FOR COMPASS
end

run MovieCollector::Application

# ENV['RAILS_ENV'] = ENV['RACK_ENV'] || 'development'


# use Rack::Tidy
# use Rails::Rack::LogTailer
# use Rails::Rack::Static
# run ActionController::Dispatcher.new
