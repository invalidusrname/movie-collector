# frozen_string_literal: true

require "rails_helper"
require "support/features/clearance_helpers"

RSpec.describe "Visitor signs up" do
  it "by navigating to the page" do
    visit sign_in_path

    click_link I18n.t("sessions.form.sign_up")

    expect(page).to have_current_path sign_up_path, ignore_query: true
  end

  it "with valid email and password" do
    sign_up_with "valid@example.com", "password"

    expect_user_to_be_signed_in
  end

  it "tries with invalid email" do
    sign_up_with "invalid_email", "password"

    expect_user_to_be_signed_out
  end

  it "tries with blank password" do
    sign_up_with "valid@example.com", ""

    expect_user_to_be_signed_out
  end

  it "tries with invalid email" do
    sign_up_with "invalidemail", "password"

    expect_user_to_be_signed_out
  end
end
