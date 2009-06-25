class UsersMoviesController < ApplicationController
  before_filter :require_login, :unless => :signed_in?

  # GET /users_movies
  # GET /users_movies.xml
  # GET /users_movies.fbml
  def index
    @users_movies = current_user.users_movies.all(:include => :movie, :order => movie_sort_order(params))

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users_movies }
      format.fbml
    end
  end

  def friends
    respond_to do |format|
      format.html # friends.html.erb
      format.xml  { render :xml => @users_movies }
      format.fbml
    end
  end

  # GET /users_movies/new
  # GET /users_movies/new.xml
  def new
    @users_movie = UsersMovie.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @users_movie }
      format.fbml
    end
  end

  # POST /users_movies
  # POST /users_movies.xml
  def create
    if params[:movie][:upc]
      movie = Movie.find_by_upc(params[:movie][:upc])

      if movie.nil?
        movie = Movie.new(Movie.lookup_on_amazon(params[:movie][:upc]))
      end
    end

    respond_to do |format|
      if movie.valid?
        current_user.movies << movie unless current_user.movies.include?(movie)

        users_movie = current_user.users_movies.find_by_movie_id(movie.id)
        users_movie.rating = params[:movie][:rating]
        users_movie.save

        flash[:notice] = 'Movie was successfully created.'
        format.html { redirect_to(users_movies_path) }
      else
        format.html { render :action => "new" }
      end
    end
  end
  
  # DELETE /users_movies/1
  # DELETE /users_movies/1.xml
  def destroy
    @users_movie = UsersMovie.find(params[:id])
    @users_movie.destroy

    respond_to do |format|
      format.html { redirect_to(users_movies_url) }
      format.xml  { head :ok }
    end
  end
end
