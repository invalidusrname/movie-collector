# frozen_string_literal: true

ENV['RAILS_ENV'] = 'test'
require File.expand_path('../config/environment', __dir__)
require 'rails/test_help'

module ActiveSupport
  class TestCase
    # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
    #
    # Note: You'll currently still have to declare fixtures explicitly in integration tests
    # -- they do not yet inherit this setting
    fixtures :all

    # Add more helper methods to be used by all tests here...

    def sign_in_as(user)
      @controller.current_user = user
      user
    end

    def sign_in
      u = User.new(email: 'test@domain.org', email_confirmed: true)
      u.password              = 'pass'
      u.password_confirmation = 'pass'
      u.admin = false
      u.save

      sign_in_as(u)
    end

    def sign_in_admin
      u = User.new(email: 'test@domain.org', email_confirmed: true)
      u.password              = 'pass'
      u.password_confirmation = 'pass'
      u.admin = true
      u.save

      sign_in_as(u)
    end
  end
end

require 'mocha'
