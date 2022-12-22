# frozen_string_literal: true

class BoxOfficeFilmsController < ApplicationController
  def index
    @films = BoxOfficeFilm.top_films
    @this_weeks_films = BoxOfficeFilm.this_week

    respond_to do |format|
      format.html
      format.xml { render xml: @films }
    end
  end
end
