# frozen_string_literal: true

class SessionsController < Clearance::SessionsController
  def new
    render template: "/sessions/new"
  end

  private

  def flash_success_after_destroy
    flash[:success] = translate(:signed_out, default: "Logged out.")
  end
end
