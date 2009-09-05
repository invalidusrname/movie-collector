# Settings specified here will take precedence over those in config/environment.rb

# The production environment is meant for finished, "live" apps.
# Code is not reloaded between requests
config.cache_classes = true

# Full error reports are disabled and caching is turned on
config.action_controller.consider_all_requests_local = false
config.action_controller.perform_caching             = true
config.action_view.cache_template_loading            = true

# See everything in the log (default is :info)
# config.log_level = :debug

# Use a different logger for distributed setups
# config.logger = SyslogLogger.new

# Use a different cache store in production
# config.cache_store = :mem_cache_store

# Enable serving of images, stylesheets, and javascripts from an asset server
config.action_controller.asset_host = "http://moviecollector.org"

# Disable delivery errors, bad email addresses will be ignored
# config.action_mailer.raise_delivery_errors = false

# Enable threaded mode
# config.threadsafe!

# MAIL SETTINGS
config.action_mailer.raise_delivery_errors = true
config.action_mailer.perform_deliveries = true
config.action_mailer.delivery_method = :smtp

config.action_mailer.smtp_settings = {
  :address => APP_CONFIG['mail']['address'],
  :port => APP_CONFIG['mail']['port'],
  :domain => APP_CONFIG['mail']['domain'],
  # :authentication => APP_CONFIG['mail']['authentication'],
  # :user_name => APP_CONFIG['mail']['user_name'],
  # :password => APP_CONFIG['mail']['password']
}

HOST = "moviecollector.org"
