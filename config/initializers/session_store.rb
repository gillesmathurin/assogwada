# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_assogwada_session',
  :secret      => '4893e022adfab3c4d314196eaea1c48f94db9f26792f8c0b12867b4fa9f4e6e851c0d85bb6c7f1b53039c04434e2166a2f15eea5b59569b6e1d3946f90d680a0'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
ActionController::Base.session_store = :active_record_store
