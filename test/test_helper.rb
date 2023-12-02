# frozen_string_literal: true

ENV["RAILS_ENV"] = "test"
require_relative "../config/environment"
require "rails/test_help"

require "clearance/test_unit"

module ActiveSupport
  class TestCase
    # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
    #
    # Note: You'll currently still have to declare fixtures explicitly in integration tests
    # -- they do not yet inherit this setting
    fixtures :all
    include FactoryBot::Syntax::Methods

    # Add more helper methods to be used by all tests here...

    def create_admin
      u = User.new(email: "test@domain.org", email_confirmed: true)
      u.password = "pass"
      u.admin = true
      u.save

      u
    end

    def sign_in_admin
      u = create_admin

      post session_path, params: {
        session: {
          email: u.email,
          password: u.password
        }
      }

      # sign_in_as(u)
    end
  end
end

require "mocha"
