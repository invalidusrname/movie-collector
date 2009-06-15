class User < ActiveRecord::Base
  include Clearance::User
  include FacebookerAuthentication::Model
  has_many :movies
end
