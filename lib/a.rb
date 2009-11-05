def add_movies(upcs)
  failed = []
  current_user = User.first

  upcs.each do |upc|
    begin

      movie = Movie.find_by_upc(upc)

      if movie.nil?
        movie = Movie.new(Movie.lookup_on_amazon(upc))
      end

      if movie.valid?
        current_user.movies << movie unless current_user.movies.include?(movie)

        users_movie = current_user.users_movies.find_by_movie_id(movie.id)
        users_movie.save
      end

    rescue Exception => e
      puts e
      failed << upc
    end
  end

  if failed.size > 0
    puts "The following UPCs weren't added: #{failed.join(',')}"
  end
end