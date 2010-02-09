class UsersMoviesController < ApplicationController
  before_filter :require_login, :unless => :signed_in?

  # GET /users_movies
  # GET /users_movies.xml
  # GET /users_movies.fbml
  def index
    options = { :order => movie_sort_order(params),
                :include =>  [:movie => :genre],
                :page => params[:page],
                :per_page => params[:max_pages] || 10 }

    search_options = {}

    if params[:letter].present? && params[:letter] != 'All'
      search_options[:starts_with] = true
      term = params[:letter]
    end

    term ||= params[:search]

    @users_movies = current_user.users_movies.search(term, search_options, options)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users_movies }
      # format.fbml
    end
  end

  def recently_added
    @users_movies = current_user.users_movies.all(:include => :movie, :limit => 5, :order => 'users_movies.id DESC')

    respond_to do |format|
      format.html
      # format.fbml
    end
  end

  def friends
    respond_to do |format|
      format.html # friends.html.erb
      format.xml  { render :xml => @users_movies }
      # format.fbml
    end
  end

  # GET /users_movies/new
  # GET /users_movies/new.xml
  def new
    @users_movie = UsersMovie.new
    @users_movie.build_movie

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @users_movie }
      # format.fbml
    end
  end

  # POST /users_movies
  # POST /users_movies.xml
  def create
    @users_movie = UsersMovie.new(params[:users_movie])
    @users_movie.user = current_user
    @users_movie.rating = params[:rating_rated]

    upc = @users_movie.movie.upc
    movie = Movie.find_by_upc(upc)

    if movie.nil? && upc.present?
      movie_attributes = Movie.lookup_on_amazon(upc)
      if movie_attributes[:title]
        @users_movie.movie = Movie.new(movie_attributes)
      end
    end

    respond_to do |format|
      if @users_movie.valid?

        unless current_user.movies.find_by_upc(@users_movie.movie.upc)
          @users_movie.save
        end

        flash[:notice] = 'Movie was successfully created.'
        format.html { redirect_to(users_movies_path) }
        # format.fbml { redirect_to(users_movies_path) }
      else
        format.html { render :action => "new" }
        # format.fbml { render :action => "new" }
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

  def show
    @users_movie = current_user.users_movies.find(params[:id])
    respond_to do |format|
      format.html
      format.xml
      # format.fbml
    end
  end

  def add_rating
    m = UsersMovie.find(params[:id])
    if m
      m.update_attribute(:rating, params[:rated])
    end
    render :json => 'ok'
  end
end
