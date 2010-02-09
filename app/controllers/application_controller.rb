# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include Clearance::Authentication
  # include FacebookerAuthentication::Controller

  # before_filter :facebook_login_required, :if => :request_comes_from_facebook?

  unless Rails.env.development?
    rescue_from ActiveRecord::RecordNotFound, ActionView::TemplateError,
      ActionController::UnknownAction, ActionController::RoutingError,
      :with => :render_404
  end

  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  protected

    def require_login
      deny_access("Login Required")
    end

    def require_admin
      unless signed_in? && current_user.admin?
        deny_access("Restricted Area")
      end
    end

    # redirect users once they've authorized the application
    # intended to work with facebook canvas pages, not facebook connect
    def after_facebook_login_url
      # request.request_uri
      "http://apps.facebook.com/#{Facebooker.facebooker_config['canvas_page_name']}"
    end

    def movie_sort_order(params)
      if params[:sort] == 'genre'
        sort = 'genres.name'
      else
        sort = Movie.column_names.include?(params[:sort]) ? params[:sort] : 'movies.title'
      end
      dir = (params[:dir] && params[:dir].downcase == 'desc') ? 'desc' : 'asc'
      "#{sort} #{dir}"
    end

    # render 404 errors so the layout looks like the rest of the app
    def render_404(exception)
      # notify_hoptoad(exception)
      logger.debug(exception)
      render :file => "#{Rails.root}/public/404.html",
             :layout => 'application',
             :status => 404
    end
end
