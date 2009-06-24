class BoxOfficeFilmsController < ApplicationController
  def index
    @films = BoxOfficeFilm.top_films
    @this_weeks_films = BoxOfficeFilm.this_week
    respond_to do |format|
      format.html # index.html.haml
      format.xml  { render :xml => @films }
      format.fbml
    end
  end
end
