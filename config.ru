# frozen_string_literal: true

# This file is used by Rack-based servers to start the application.

require ::File.expand_path("config/environment", __dir__)

run MovieCollector::Application

# ENV['RAILS_ENV'] = ENV['RACK_ENV'] || 'development'

# use Rack::Tidy
# use Rails::Rack::LogTailer
# use Rails::Rack::Static
# run ActionController::Dispatcher.new
