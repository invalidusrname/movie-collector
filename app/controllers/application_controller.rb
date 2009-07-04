# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base

  include Clearance::Authentication
  include FacebookerAuthentication::Controller

  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  filter_parameter_logging :password
  
  protected
    def require_login
      deny_access("Login Required")
    end

    def require_admin
      unless signed_in? && current_user.admin?
        deny_access("Restricted Area")
      end
    end
    
    def movie_sort_order(params)
      sort = Movie.column_names.include?(params[:sort]) ? params[:sort] : 'movies.title'
      dir = (params[:dir] && params[:dir].downcase == 'desc') ? 'desc' : 'asc'
      "#{sort} #{dir}"
    end
end
