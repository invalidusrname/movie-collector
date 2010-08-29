Clearance.configure do |config|
  config.mailer_sender     = 'me@example.com'
  config.cookie_expiration = lambda { 2.weeks.from_now.utc }
end