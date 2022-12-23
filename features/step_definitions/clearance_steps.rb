# frozen_string_literal: true

# General

Then(/^I should see error messages$/) do
  assert_match(/error(s)?\n?prohibited/m, page.body)
end

# Database

Given(/^no user exists with an email of "(.*)"$/) do |email|
  user = User.find_by(email:)
  assert_nil user
end

Given(%r{^I signed up with "(.*)/(.*)"$}) do |email, password|
  create(:user, email:, password:)
end

Given(%r{^I am signed up and confirmed as "(.*)/(.*)"$}) do |email, password|
  create(:user, email:, password:)
end

# Session

Then(/^I should be signed in$/) do
  assert page.body.include? "Sign out"
end

Then(/^I should be signed out$/) do
  assert page.body.include? "Sign in"
end

When(/^session is cleared$/) do
  page.reset_session!
end

# Emails

Then(/^a confirmation message should be sent to "(.*)"$/) do |email|
  user = User.find_by(email:)
  sent = ActionMailer::Base.deliveries.first

  assert_equal [user.email], sent.to
  assert_match(/confirm/i, sent.subject)
  assert user.confirmation_token.present?

  assert_match(/#{user.confirmation_token}/, sent.body)
end

When(/^I follow the confirmation link sent to "(.*)"$/) do |email|
  user = User.find_by(email:)
  visit new_user_confirmation_path(user_id: user, token: user.confirmation_token)
end

Then(/^a password reset message should be sent to "(.*)"$/) do |email|
  user = User.find_by(email:)
  sent = ActionMailer::Base.deliveries.first
  assert_equal [user.email], sent.to
  assert_match(/password/i, sent.subject)

  assert user.confirmation_token.present?
  assert_match(/#{user.confirmation_token}/, sent.body.encoded)
end

When(/^I follow the password reset link sent to "(.*)"$/) do |email|
  user = User.find_by(email:)
  visit edit_user_password_path(user_id: user, token: user.confirmation_token)
end

When(/^I try to change the password of "(.*)" without token$/) do |email|
  user = User.find_by(email:)
  visit edit_user_password_path(user_id: user)
end

Then(/^I should be forbidden$/) do
  assert_response :forbidden
end

# Actions

When(%r{^I sign in( with "remember me")? as "(.*)/(.*)"$}) do |remember, email, password|
  step %(I go to the sign in page)
  step %(I fill in "Email" with "#{email}")
  step %(I fill in "Password" with "#{password}")
  step %(I check "Remember me") if remember
  step %(I press "Sign in")
end

When(/^I sign out$/) do
  click_link "Sign out"
end

When(/^I request password reset link to be sent to "(.*)"$/) do |email|
  step %(I go to the request password page)
  step %(I fill in "Email address" with "#{email}")
  step %(I press "Reset password")
end

When(/^I update my password with "(.*)"$/) do |password|
  step %(I fill in "Choose password" with "#{password}")
  step %(I press "Save this password")
end
