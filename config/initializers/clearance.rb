# frozen_string_literal: true

Clearance.configure do |config|
  config.mailer_sender = "me@example.com"
  config.cookie_expiration = ->(_cookies) { 2.weeks.from_now.utc }
end
