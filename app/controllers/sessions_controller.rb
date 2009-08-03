class SessionsController < Clearance::SessionsController
  # skip application controller's filter
  # will allow facebook convas and facebook connect to work
  skip_before_filter :facebook_login_required

  # but still use filter for these actions
  before_filter :facebook_login_required, :only => %w(facebook_new facebook_create)

  def new
    render :template => '/sessions/new'
  end

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

    sign_in(user)
    set_current_user
    redirect_to my_movies_path
  end

  def destroy
    # clearance currently uses reset_session when forgetting a user
    # that doesn't work with rails 2.3.2, so we're doing it manually here
    if signed_in?
      current_user.forget_me!
      @_current_user = nil
      current_user # shouldn't be needed, but sign_out.feature is failing without this
    end

    cookies.delete(:remember_token)
    session.clear
    flash_success_after_destroy
    redirect_to url_after_destroy
  end

  private
    def flash_success_after_destroy
      flash[:success] = translate(:signed_out, :default =>  "Logged out.")
    end
end
