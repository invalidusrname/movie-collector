# frozen_string_literal: true

# Edit this Gemfile to bundle your application's dependencies.
source "https://rubygems.org"

gem "rails", "~> 7.2"

gem "bootsnap", require: false
gem "clearance", "~> 2.9"
gem "cssbundling-rails", "~> 1.4"
gem "haml", ">= 3.0.18"
gem "iconv", "~> 1.1.0"
gem "importmap-rails"
gem "jbuilder", "~> 2.13"
gem "json", "~> 2.10"
gem "nokogiri", "~> 1.18"
gem "puma", "~> 6.6"
gem "ruby-aaws", "~> 0.7", require: "amazon"
gem "sprockets-rails"
gem "sqlite3", "~> 2.2"
gem "stimulus-rails", "~> 1.3"
gem "turbo-rails", "~> 1.5"
gem "will_paginate", "~> 4.0"

group :development do
  gem "web-console", "~> 4.2"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver", "~> 4.25.0"
  gem "shoulda", "~> 4.0"
  gem "webrat", "~> 0.7"
end

group :development, :test do
  gem "cucumber-rails", require: false
  gem "database_cleaner", "~> 2.1"
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[mri mingw x64_mingw]
  gem "factory_bot_rails", "~> 6.4.4"
  gem "mocha", "~> 2.7"
  gem "pry", "~> 0.15"
  gem "rails-controller-testing", "~> 1.0.5"
  gem "rspec-rails", "~> 7.1.0"
  gem "rubocop-rails", "~> 2.27", require: false
  gem "rubocop-rspec", "~> 3.3", require: false
end
