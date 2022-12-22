# frozen_string_literal: true

class UsersMoviesController < ApplicationController
  before_action :require_login, unless: :signed_in?

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
  end

  def recently_added
    @users_movies = current_user.users_movies.includes(:movie).limit(5).order("users_movies.id DESC")
  end

  def friends; end

  # GET /users_movies/new
  # GET /users_movies/new.xml
  def new
    @users_movie = UsersMovie.new
    @users_movie.build_movie
  end

  # POST /users_movies
  # POST /users_movies.xml
  def create
    @users_movie = UsersMovie.new(users_movie_params)
    @users_movie.user = current_user
    @users_movie.rating = params[:rating_rated]

    respond_to do |format|
      if @users_movie.save
        format.html { redirect_to movies_path(@users_movie.movie), notice: "Movie was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users_movies/1
  # DELETE /users_movies/1.xml
  def destroy
    @users_movie = UsersMovie.find(params[:id])
    @users_movie.destroy
  end

  def show
    @users_movie = current_user.users_movies.find(params[:id])
  end

  def add_rating
    m = UsersMovie.find(params[:id])
    m&.update_attribute(:rating, params[:rated])
    render json: "ok"
  end

  def users_movie_params
    params.require(:users_movie).permit(movie_attributes: %i[upc title format genre_id])
  end
end
