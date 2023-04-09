# frozen_string_literal: true

# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include Clearance::Controller

  unless Rails.env.development?
    rescue_from ActiveRecord::RecordNotFound, ActionView::TemplateError,
                ActionController::RoutingError,
                with: :render_404
  end

  helper :all # include all helpers, all the time
  protect_from_forgery with: :exception # See ActionController::RequestForgeryProtection for details

  protected

  def require_login
    deny_access("Login Required")
  end

  def require_admin
    return if signed_in? && current_user.admin?

    deny_access("Restricted Area")
  end

  def movie_sort_order(params)
    sort = if params[:sort] == "genre"
             "genres.name"
           else
             Movie.column_names.include?(params[:sort]) ? params[:sort] : "movies.title"
           end
    dir = params[:dir] && params[:dir].downcase == "desc" ? "desc" : "asc"
    "#{sort} #{dir}"
  end

  # render 404 errors so the layout looks like the rest of the app
  def render_404(exception)
    logger.debug(exception)
    render file: "#{Rails.root}/public/404.html",
           layout: "application",
           status: :not_found
  end
end
