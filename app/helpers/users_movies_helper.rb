module UsersMoviesHelper
  
  def thumbnail(movie)
    movie.thumbnail || '#'
  end
end
