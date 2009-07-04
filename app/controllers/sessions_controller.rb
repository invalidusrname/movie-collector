class SessionsController < Clearance::SessionsController
  before_filter :facebook_login_required, :only => %w(facebook_new facebook_create)

  def facebook_new
    # handle the case where ensure_authenticated_to_facebook filter passes through,
    # like when the user has already authenticated and we have the facebook cookies
    redirect_to facebook_create_session_url
  end

  # TODO: find_or_create user based on facebook credentials
  def facebook_create
    sign_user_in(current_user)
    set_current_user
    redirect_to my_movies_path
  end
  
  def destroy
    forget(current_user)
    reset_session
    flash[:notice] = 'You have been logged out.'
    redirect_to url_after_destroy
  end
end
