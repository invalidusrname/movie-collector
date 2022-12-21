# frozen_string_literal: true

class UsersMoviesController < ApplicationController
  before_action :require_login, unless: :signed_in?

  respond_to :html, :xml

  # GET /users_movies
  # GET /users_movies.xml
  # GET /users_movies.fbml
  def index
    options = { order: movie_sort_order(params),
                include: [movie: :genre],
                page: params[:page],
                per_page: params[:max_pages] || 10 }

    search_options = {}

    if params[:letter].present? && params[:letter] != "All"
      search_options[:starts_with] = true
      term = params[:letter]
    end

    term ||= params[:search]

    @users_movies = current_user.users_movies.search(term, search_options, options)

    respond_with(@users_movies)
  end

  def recently_added
    @users_movies = current_user.users_movies.all(include: :movie, limit: 5, order: "users_movies.id DESC")

    respond_with(@users_movies)
  end

  def friends
    respond_with(@users_movies)
  end

  # GET /users_movies/new
  # GET /users_movies/new.xml
  def new
    @users_movie = UsersMovie.new
    @users_movie.build_movie

    respond_with(@users_movie)
  end

  # POST /users_movies
  # POST /users_movies.xml
  def create
    @users_movie = UsersMovie.new(params[:users_movie])
    @users_movie.user = current_user
    @users_movie.rating = params[:rating_rated]

    flash[:notice] = "Movie was successfully created." if @users_movie.save

    respond_with(@users_movie)
  end

  # DELETE /users_movies/1
  # DELETE /users_movies/1.xml
  def destroy
    @users_movie = UsersMovie.find(params[:id])
    @users_movie.destroy

    respond_with(@users_movie)
  end

  def show
    @users_movie = current_user.users_movies.find(params[:id])
    respond_with(@users_movie)
  end

  def add_rating
    m = UsersMovie.find(params[:id])
    m&.update_attribute(:rating, params[:rated])
    render json: "ok"
  end
end
