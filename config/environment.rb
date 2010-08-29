# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
MovieCollector::Application.initialize!

DO_NOT_REPLY = APP_CONFIG['mail']['no_reply']
