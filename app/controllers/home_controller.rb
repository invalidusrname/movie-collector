class HomeController < ApplicationController
  def index
    respond_to do |format|
      format.html
      format.fbml
      # format.fbml { redirect_to(users_movies_path) }
    end
  end
end
