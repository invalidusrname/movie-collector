class MoviesController < ApplicationController
  before_filter :require_admin, :except => ['amazon_search', 'index', 'show']

  respond_to :html, :xml

  # GET /movies
  # GET /movies.xml
  def index
    options = { :order => movie_sort_order(params),
                :include =>  :genre,
                :page => params[:page],
                :per_page => params[:max_pages] || 10 }

    search_options = {}

    if params[:letter].present? && params[:letter] != 'All'
      search_options[:starts_with] = true
      term = params[:letter]
    end

    term ||= params[:search]

    @movies = Movie.search(term, search_options, options)

    respond_with(@movies)
  end

  # GET /movies/1
  # GET /movies/1.xml
  def show
    @movie = Movie.find(params[:id])

    respond_with(@movie)
  end

  # GET /movies/new
  # GET /movies/new.xml
  def new
    @movie = Movie.new

    respond_with(@movie)
  end

  # GET /movies/1/edit
  def edit
    @movie = Movie.find(params[:id])
  end

  # POST /movies
  # POST /movies.xml
  def create
    @movie = Movie.new(params[:movie])

    flash[:notice] = 'Movie was successfully created.' if @movie.save
    respond_with(@movie)
  end

  # PUT /movies/1
  # PUT /movies/1.xml
  def update
    @movie = Movie.find(params[:id])

    flash[:notice] = 'Movie was successfully updated.' if @movie.update_attributes(params[:movie])
    respond_with(@movie)
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
    if params[:title].present?
      m = Movie.search_titles_on_amazon(params[:title])
    elsif params[:upc].present?
      m = Movie.lookup_on_amazon(params[:upc])
    else
      m = Hash.new
    end

    respond_to do |format|
      format.json {
        render :json => m
      }
    end
  end
end
