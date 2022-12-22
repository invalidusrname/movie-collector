# frozen_string_literal: true

class MoviesController < ApplicationController
  before_action :require_admin, except: %w[amazon_search index show]

  # GET /movies
  # GET /movies.xml
  def index
    options = { order: movie_sort_order(params),
                include: :genre,
                page: params[:page],
                per_page: params[:max_pages] || 10 }

    search_options = {}

    if params[:letter].present? && params[:letter] != "All"
      search_options[:starts_with] = true
      term = params[:letter]
    end

    term ||= params[:search]

    @movies = Movie.search(term, search_options, options) || []
  end

  # GET /movies/1
  # GET /movies/1.xml
  def show
    @movie = Movie.find(params[:id])
  end

  # GET /movies/new
  # GET /movies/new.xml
  def new
    @movie = Movie.new
  end

  # GET /movies/1/edit
  def edit
    @movie = Movie.find(params[:id])
  end

  # POST /movies
  # POST /movies.xml
  def create
    @movie = Movie.new(movie_params)

    respond_to do |format|
      if @movie.save
        format.html { redirect_to movie_url(@movie), notice: "Movie was successfully created." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # PUT /movies/1
  # PUT /movies/1.xml
  def update
    @movie = Movie.find(params[:id])

    respond_to do |format|
      if @movie.update(movie_params)
        format.html { redirect_to movie_url(@movie), notice: "Movie was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /movies/1
  # DELETE /movies/1.xml
  # def destroy
  #   @movie = Movie.find(params[:id])
  #   @movie.destroy
  #
  #   respond_to do |format|
  #     format.html { redirect_to(movies_url) }
  #     format.xml  { head :ok }
  #   end
  # end

  def amazon_search
    m = if params[:title].present?
          Movie.search_titles_on_amazon(params[:title])
        elsif params[:upc].present?
          Movie.lookup_on_amazon(params[:upc])
        else
          {}
        end

    respond_to do |format|
      format.json do
        render json: m
      end
    end
  end

  def movie_params
    params.require(:movie).permit(:upc, :title, :format, :genre)
  end
end
