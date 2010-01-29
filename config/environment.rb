# Be sure to restart your server when you modify this file

# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.3.5' unless defined? RAILS_GEM_VERSION

# $DEBUG = true

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

DO_NOT_REPLY = APP_CONFIG['mail']['no_reply']

require 'rack/tidy'

Rails::Initializer.run do |config|
  # Settings in config/environments/* take precedence over those specified here.
  # Application configuration should go into files in config/initializers
  # -- all .rb files in that directory are automatically loaded.

  config.middleware.use Rack::Tidy

  config.gem 'hpricot'
  config.gem 'json'
  config.gem "newrelic_rpm"

  config.gem "clearance",
    :source  => 'http://gemcutter.org',
    :version => '>= 0.6.9'

  config.gem "haml",
    :lib     => 'haml',
    :version => '>= 2.2.1'

  config.gem 'ruby-aaws',
    :lib     => 'amazon',
    :version => '= 0.6.0'

  config.gem 'ruby-debug'

  config.gem "facebooker",
    :source  => 'http://gemcutter.org',
    :version => '>= 1.0.45'

  config.gem 'will_paginate',
    :source => 'http://gemcutter.org',
    :version => '~> 2.3.11'

  # config.gem 'twitter-auth', :lib => 'twitter_auth'

  config.time_zone = 'UTC'

  config.action_controller.allow_forgery_protection    = false
end
