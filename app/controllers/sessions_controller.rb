class SessionsController < Clearance::SessionsController
  # skip application controller's filter
  # will allow facebook convas and facebook connect to work
  skip_before_filter :facebook_login_required

  # but still use filter for these actions
  before_filter :facebook_login_required, :only => %w(facebook_new facebook_create)

  def facebook_new
    # handle the case where ensure_authenticated_to_facebook filter passes through,
    # like when the user has already authenticated and we have the facebook cookies
    redirect_to facebook_create_session_url
  end

  # TODO: find_or_create user based on facebook credentials
  def facebook_create
    facebook_user = facebook_session.user
    facebook_id = facebook_user.facebook_id

    user = User.find_by_facebook_id(facebook_id)
    
    unless user
      user = User.create! do |u|
        u.facebook_id = facebook_id
        u.email_confirmed = true
      end

      mail = ClearanceMailer.create_facebook_welcome(user)
      facebook_user.send_email(mail.subject, mail.body)
    end

    sign_user_in(user)
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
