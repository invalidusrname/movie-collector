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

  # GET /movies/new
  # GET /movies/new.xml
  def new
    @users_movie = UsersMovie.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @users_movie }
      format.fbml
    end
  end
end
