class UsersMovie < ActiveRecord::Base
  belongs_to :movie
  belongs_to :user
  belongs_to :borrower, :class_name => "User", :foreign_key => "borrower_id"

  validates_associated :movie
  validates_inclusion_of :rating, :in => Movie::RATINGS

  before_validation :check_for_movie

  accepts_nested_attributes_for :movie

  def loan_movie_to(user)
    self.borrower = user
  end

  def return_movie
    self.borrower = nil
  end

  def check_for_movie
    if self.new_record? && self.movie && self.movie.upc.present?
      upc = self.movie.upc
      existing_movie = Movie.find_by_upc(upc)

      if existing_movie
        self.movie = existing_movie
      else
        movie_attributes = Movie.lookup_on_amazon(upc)
        if movie_attributes[:title]
          self.movie = Movie.new(movie_attributes)
        end
      end
    end
  end

  def self.search(search, search_options = {}, options = {})
    if search.to_s.length > 0
      if search_options.has_key? :starts_with
        options.merge!(:conditions => ['movies.title LIKE ?', "#{search}%"])
      else
        options.merge!(:conditions => ['movies.title LIKE ?', "%#{search}%"])
      end
    end
    paginate(:all, options)
  end
end
