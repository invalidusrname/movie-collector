# frozen_string_literal: true

# Edit this Gemfile to bundle your application's dependencies.
source "https://rubygems.org"

gem "rails", "~> 7.1"

gem "bootsnap", require: false
gem "clearance", "~> 2.7"
gem "cssbundling-rails", "~> 1.4"
gem "haml", ">= 3.0.18"
gem "iconv", "~> 1.0.8"
gem "importmap-rails"
gem "jbuilder", "~> 2.12"
gem "json", "~> 2.7"
gem "nokogiri", "~> 1.16"
gem "puma", "~> 6.4"
gem "ruby-aaws", "~> 0.7", require: "amazon"
gem "sprockets-rails"
gem "sqlite3", "~> 1.7"
gem "stimulus-rails", "~> 1.3"
gem "turbo-rails", "~> 1.5"
gem "will_paginate", "~> 4.0"

group :development do
  gem "web-console", "~> 4.2"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver", "~> 4.20.1"
  gem "shoulda", "~> 4.0"
  gem "webrat", "~> 0.7"
end

group :development, :test do
  gem "cucumber-rails", require: false
  gem "database_cleaner", "~> 2.0"
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[mri mingw x64_mingw]
  gem "factory_bot_rails", "~> 6.4.3"
  gem "mocha", "~> 2.2"
  gem "pry", "~> 0.14"
  gem "rails-controller-testing", "~> 1.0.5"
  gem "rspec-rails", "~> 6.1.2"
  gem "rubocop-rails", "~> 2.24", require: false
  gem "rubocop-rspec", "~> 3.0", require: false
end
