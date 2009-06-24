class User < ActiveRecord::Base
  include Clearance::User
  include FacebookerAuthentication::Model
  has_many :movies, :through => :users_movies
  has_many :users_movies
end
