# frozen_string_literal: true

# Edit this Gemfile to bundle your application's dependencies.
source "http://rubygems.org"

gem "rails", "~> 7.0"

gem "bootsnap", require: false
gem "clearance", "~> 2.6"
gem "cssbundling-rails", "~> 1.1"
gem "haml", ">= 3.0.18"
gem "iconv", "~> 1.0.8"
gem "importmap-rails"
gem "jbuilder", "~> 2.11"
gem "json", "~> 2.6"
gem "nokogiri", "~> 1.14"
gem "puma", "~> 6.1"
gem "ruby-aaws", "~> 0.7", require: "amazon"
gem "sprockets-rails"
gem "sqlite3", "~> 1.6"
gem "stimulus-rails", "~> 1.2"
gem "turbo-rails", "~> 1.4"
gem "will_paginate", "~> 3.3"

group :development do
  gem "web-console", "~> 4.2"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver", "~> 4.8.1"
  gem "shoulda", "~> 4.0"
  gem "webdrivers", "~> 5.2"
  gem "webrat", "~> 0.7"
end

group :development, :test do
  gem "cucumber-rails", require: false
  gem "database_cleaner", "~> 2.0"
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[mri mingw x64_mingw]
  gem "factory_bot_rails", "~> 6.2.0"
  gem "mocha", "~> 2.0"
  gem "pry", "~> 0.14"
  gem "rails-controller-testing", "~> 1.0.5"
  gem "rspec-rails", "~> 6.0.0"
  gem "rubocop-rails", "~> 2.18", require: false
  gem "rubocop-rspec", "~> 2.18", require: false
end
