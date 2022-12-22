# frozen_string_literal: true

class User < ApplicationRecord
  include Clearance::User

  validates :password, confirmation: true

  has_many :movies, through: :users_movies
  has_many :users_movies
end
