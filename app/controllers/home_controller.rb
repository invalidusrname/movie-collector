# frozen_string_literal: true

class HomeController < ApplicationController
  before_action :redirect, if: :signed_in?

  def index; end

  protected

  def redirect
    redirect_to recently_added_users_movies_path
  end
end
