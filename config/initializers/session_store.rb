# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_movie_collector_session',
  :secret      => 'f80cf411b674e9a47d9f78783d50db89b40ad59789231f5a2fd90882ee0fa4dbe3baaabee442cd9622feb1a19b7a419e42b8f4c5fc2f595e586b266716db5f51'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
