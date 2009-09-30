class HomeController < ApplicationController
  before_filter :redirect, :if => :signed_in?

  def index
    respond_to do |format|
      format.html
      format.fbml
      format.iphone
    end
  end

  protected
    def redirect
      redirect_to recently_added_users_movies_path
    end
end
