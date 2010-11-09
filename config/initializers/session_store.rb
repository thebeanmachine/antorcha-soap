# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_antorcha-soap_session',
  :secret      => 'd1cc2bd026ccb924a650b4227dc2a09aa91d088fbefcd6dd2ee693349a26ccd2cd3ec60b0c9204f5b1666ab376ab37f5fe85b44890202e268ca3f8ab232c0a78'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
