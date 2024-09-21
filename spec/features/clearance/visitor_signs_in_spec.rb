# frozen_string_literal: true

require "rails_helper"
require "support/features/clearance_helpers"

RSpec.describe "Visitor signs in" do
  it "with valid email and password" do
    create_user "user@example.com", "password"
    sign_in_with "user@example.com", "password"

    expect_user_to_be_signed_in
  end

  it "with valid mixed-case email and password" do
    create_user "user.name@example.com", "password"
    sign_in_with "User.Name@example.com", "password"

    expect_user_to_be_signed_in
  end

  it "tries with invalid password" do
    create_user "user@example.com", "password"
    sign_in_with "user@example.com", "wrong_password"

    expect_page_to_display_sign_in_error
    expect_user_to_be_signed_out
  end

  it "tries with invalid email" do
    sign_in_with "unknown.email@example.com", "password"

    expect_page_to_display_sign_in_error
    expect_user_to_be_signed_out
  end

  private

  def create_user(email, password)
    FactoryBot.create(:user, email:, password:)
  end

  def expect_page_to_display_sign_in_error
    expect(page.body).to include(
      I18n.t("flashes.failure_after_create", sign_up_path:)
    )
  end
end
