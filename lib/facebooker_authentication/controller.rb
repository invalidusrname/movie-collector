module FacebookerAuthentication
  module Controller
    def self.included(includer)
      #install the current_user helper and the before filter

      # commented out because Clearance also uses current_user
      # includer.module_eval do
      #   helper_attr :current_user
      #   attr_accessor :current_user
      # end
    end

    def set_current_user
      #this is a facebooker method to make sure we have a session
      set_facebook_session
      # if the session isn't secured, we don't have a good user id
      if facebook_session and facebook_session.secured? and !request_is_facebook_tab?
         current_user = User.for_facebook_id(facebook_session.user.to_i,facebook_session)
         current_user.update_attribute(:email_confirmed, true) unless current_user.email_confirmed?
         sign_user_in(current_user)
      end
    end

    def facebook_login_required
      if ensure_authenticated_to_facebook
        set_current_user
      end
    end
  end
end