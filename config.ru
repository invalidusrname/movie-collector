# RAILS_ROOT/config.ru
require "config/environment"
# require 'rack/tidy'

# use Rack::Tidy
use Rails::Rack::LogTailer
use Rails::Rack::Static
run ActionController::Dispatcher.new
