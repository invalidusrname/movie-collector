# frozen_string_literal: true

module UsersMoviesHelper
  def thumbnail(movie)
    movie.thumbnail || 'missing_thumbnail.jpg'
  end

  def movie_image(movie)
    movie.image || 'missing_movie.jpg'
  end
end
