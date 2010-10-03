# Edit this Gemfile to bundle your application's dependencies.
source 'http://rubygems.org'

gem "rails", "3.0.0"

# git 'git://github.com/rails/rails_upgrade.git' do
  # gem ''
# end

## Bundle edge rails:
# gem "rails", :git => "git://github.com/rails/rails.git"

## Bundle the gems you use:
# gem "bj"
# gem "hpricot", "0.6"
# gem "sqlite3-ruby", :require => "sqlite3"
# gem "aws-s3", :require => "aws/s3"

## Bundle gems used only in certain environments:

# git "git://github.com/cavalle/polyglot.git"

group :test, :development do
  gem 'mysql'
  gem "sqlite3-ruby", :require => "sqlite3"
  gem "cucumber-rails"
  gem "rspec-rails", ">= 2.0.0.beta.20"
  gem 'database_cleaner'
  gem 'webrat'
  gem 'shoulda'
  gem 'factory_girl'
  gem 'mocha'
  gem 'cucumber-rails'
end

gem 'nokogiri'
gem 'json'

# don't work out of the box. uncommenting for now
# gem "facebooker", '>= 1.0.45'
gem 'clearance', :git => "http://github.com/thoughtbot/clearance.git"

gem "haml", '>= 3.0.18'

gem 'ruby-aaws', :require => 'amazon'# :version => '= 0.6.0'

gem 'compass'
gem 'will_paginate', :git => "http://github.com/mislav/will_paginate.git", :branch => "rails3"