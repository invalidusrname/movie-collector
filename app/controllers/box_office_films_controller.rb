class BoxOfficeFilmsController < ApplicationController
  respond_to :html, :xml

  def index
    @films = BoxOfficeFilm.top_films
    @this_weeks_films = BoxOfficeFilm.this_week
    respond_with(@films)
  end
end
