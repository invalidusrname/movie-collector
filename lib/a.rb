# frozen_string_literal: true

def add_movies(upcs)
  failed = []
  current_user = User.first

  upcs.each do |upc|
    movie = Movie.find_by(upc:)

    movie = Movie.new(Movie.lookup_on_amazon(upc)) if movie.nil?

    if movie.valid?
      current_user.movies << movie unless current_user.movies.include?(movie)

      users_movie = current_user.users_movies.find_by(movie_id: movie.id)
      users_movie.save
    end
  rescue Exception => e
    Rails.logger.debug e
    failed << upc
  end

  return unless failed.size.positive?

  Rails.logger.debug "The following UPCs weren't added: #{failed.join(',')}"
end
