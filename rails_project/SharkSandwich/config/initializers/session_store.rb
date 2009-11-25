# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_SharkSandwich_session',
  :secret      => 'bdadf54515147b7b7acbc539103b2e1b6d0665179c9d50892e812361b63d6cb3262ec8a3430bca38b2febc014a4a05ec55a277ec1aec92d2dfd1b3ee20abc17f'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
