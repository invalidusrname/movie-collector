# frozen_string_literal: true

# Edit this Gemfile to bundle your application's dependencies.
source "https://rubygems.org"

gem "rails", "~> 7.0"

gem "bootsnap", require: false
gem "clearance", "~> 2.6"
gem "cssbundling-rails", "~> 1.3"
gem "haml", ">= 3.0.18"
gem "iconv", "~> 1.0.8"
gem "importmap-rails"
gem "jbuilder", "~> 2.11"
gem "json", "~> 2.6"
gem "nokogiri", "~> 1.15"
gem "puma", "~> 6.4"
gem "ruby-aaws", "~> 0.7", require: "amazon"
gem "sprockets-rails"
gem "sqlite3", "~> 1.6"
gem "stimulus-rails", "~> 1.3"
gem "turbo-rails", "~> 1.4"
gem "will_paginate", "~> 4.0"

group :development do
  gem "web-console", "~> 4.2"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver", "~> 4.10.0"
  gem "shoulda", "~> 4.0"
  gem "webdrivers", "~> 5.3"
  gem "webrat", "~> 0.7"
end

group :development, :test do
  gem "cucumber-rails", require: false
  gem "database_cleaner", "~> 2.0"
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[mri mingw x64_mingw]
  gem "factory_bot_rails", "~> 6.4.2"
  gem "mocha", "~> 2.1"
  gem "pry", "~> 0.14"
  gem "rails-controller-testing", "~> 1.0.5"
  gem "rspec-rails", "~> 6.1.0"
  gem "rubocop-rails", "~> 2.22", require: false
  gem "rubocop-rspec", "~> 2.25", require: false
end
