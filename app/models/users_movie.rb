# frozen_string_literal: true

class UsersMovie < ApplicationRecord
  belongs_to :movie
  belongs_to :user
  belongs_to :borrower, class_name: 'User'

  validates_associated :movie
  validates :rating, inclusion: { in: Movie::RATINGS }

  before_validation :check_for_movie

  accepts_nested_attributes_for :movie

  def loan_movie_to(user)
    self.borrower = user
  end

  def return_movie
    self.borrower = nil
  end

  def check_for_movie
    return unless new_record? && movie && movie.upc.present?

    upc = movie.upc
    existing_movie = Movie.find_by(upc:)

    if existing_movie
      self.movie = existing_movie
    else
      movie_attributes = Movie.lookup_on_amazon(upc)
      self.movie = Movie.new(movie_attributes) if movie_attributes[:title]
    end
  end

  def self.search(search, search_options = {}, options = {})
    if search.to_s.length.positive?
      if search_options.key? :starts_with
        options.merge!(conditions: ['movies.title LIKE ?', "#{search}%"])
      else
        options.merge!(conditions: ['movies.title LIKE ?', "%#{search}%"])
      end
    end
    paginate(:all, options)
  end
end
