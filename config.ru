# RAILS_ROOT/config.ru
require "config/environment"
# require 'rack/tidy'

ENV['RAILS_ENV'] = ENV['RACK_ENV'] || 'development'

# use Rack::Tidy
use Rails::Rack::LogTailer
use Rails::Rack::Static
run ActionController::Dispatcher.new
