# Edit this Gemfile to bundle your application's dependencies.
source 'http://gemcutter.org'

gem "rails", "3.0.0.beta"

## Bundle edge rails:
# gem "rails", :git => "git://github.com/rails/rails.git"

gem "sqlite3-ruby", :require => "sqlite3"

## Bundle the gems you use:
# gem "bj"
# gem "hpricot", "0.6"
# gem "sqlite3-ruby", :require => "sqlite3"
# gem "aws-s3", :require => "aws/s3"

## Bundle gems used only in certain environments:

git "git://github.com/cavalle/polyglot.git"

group :test do
  gem "cucumber-rails"
  gem 'rspec'
  gem "rspec-rails"
  gem 'database_cleaner'
  gem 'webrat'
  gem 'shoulda'
  gem 'factory_girl'
  gem 'mocha'
  git "git://github.com/ashleymoran/cucumber-rails.git"
end

gem 'ruby-debug', :group => [:development, :test]

gem 'hpricot'
gem 'json'

# don't work out of the box. uncommenting for now
# gem "facebooker", '>= 1.0.45'
# git "http://github.com/thoughtbot/clearance.git", :branch => 'rails3'

gem "haml", '>= 2.2.1'

gem 'ruby-aaws',
  :require => 'amazon',
  :version => '= 0.6.0'

gem 'compass'
gem 'will_paginate', '3.0.pre'


