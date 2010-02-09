class HomeController < ApplicationController
  before_filter :redirect, :if => :signed_in?

  respond_to :html

  def index
  end

  protected
    def redirect
      redirect_to recently_added_users_movies_path
    end
end
