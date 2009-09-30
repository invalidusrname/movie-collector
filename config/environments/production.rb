# Settings specified here will take precedence over those in config/environment.rb

# The production environment is meant for finished, "live" apps.
# Code is not reloaded between requests
config.cache_classes = true

# Full error reports are disabled and caching is turned on
config.action_controller.consider_all_requests_local = false
config.action_controller.perform_caching             = true
config.action_view.cache_template_loading            = true

config.action_controller.asset_host = "http://moviecollector.org"

# MAIL SETTINGS
config.action_mailer.raise_delivery_errors = true
config.action_mailer.perform_deliveries = true
config.action_mailer.delivery_method = :smtp

config.action_mailer.smtp_settings = {
  :address => APP_CONFIG['mail']['address'],
  :port => APP_CONFIG['mail']['port'],
  :domain => APP_CONFIG['mail']['domain'],
}

HOST = APP_CONFIG['mail']['domain']
