# Be sure to restart your web server when you modify this file.

# Uncomment below to force Rails into production mode when 
# you don't control web/app server and can't set it the proper way
# ENV['RAILS_ENV'] ||= 'production'

# Specifies gem version of Rails to use when vendor/rails is not present
RAILS_GEM_VERSION = '2.0.2' unless defined? RAILS_GEM_VERSION
# RAILS_GEM_VERSION = '2.1.0' unless defined? RAILS_GEM_VERSION

# Bootstrap the Rails environment, frameworks, and default configuration
require File.join(File.dirname(__FILE__), 'boot')

Rails::Initializer.run do |config|
  # Settings in config/environments/* take precedence over those specified here
  
  # Skip frameworks you're not going to use (only works if using vendor/rails)
  # config.frameworks -= [ :action_web_service, :action_mailer ]

  # Only load the plugins named here, by default all plugins in vendor/plugins are loaded
  # config.plugins = %W( exception_notification ssl_requirement )

  # Add additional load paths for your own custom dirs
  # config.load_paths += %W( #{RAILS_ROOT}/extras )
  config.load_paths << "#{RAILS_ROOT}/app/sweepers"

  # Force all environments to use the same logger level 
  # (by default production uses :info, the others :debug)
  # config.log_level = :debug
  
  # Your secret key for verifying cookie session data integrity.
  # If you change this key, all old sessions will become invalid!
  # Make sure the secret is at least 30 characters and all random, 
  # no regular words or you'll be exposed to dictionary attacks.
  # config.action_controller.session = {
  #   :session_key => '_assogwada_session',
  #   :secret      => 'c5688934bd6b9220b5dc165e7390f9f135b1e1245c8f425e27182596bab43d2f352e5fda5ecf7c72c22aeb9ae909cbd3761c4f540ef2b441fd787e72403e7fc4'
  # }

  # Use the database for sessions instead of the file system
  # (create the session table with 'rake db:sessions:create')
  config.action_controller.session_store = :active_record_store

  # Use SQL instead of Active Record's schema dumper when creating the test database.
  # This is necessary if your schema can't be completely dumped by the schema dumper, 
  # like if you have constraints or database-specific column types
  # config.active_record.schema_format = :sql

  # Activate observers that should always be running
  # config.active_record.observers = :cacher, :garbage_collector

  # Make Active Record use UTC-base instead of local time
  # config.active_record.default_timezone = :utc
  
  # See Rails::Configuration for more options 
  # configuration de l'envoi de courrier électronique
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = { 
    :address => "mail.asso-guadeloupe.fr", 
    :port => 25, 
    :domain => "asso-guadeloupe.fr",
    :authentication => :login, 
    :user_name => "gilles+asso-guadeloupe.fr", 
    :password => "$rv+&c77ul&9"
  }
  config.action_mailer.perform_deliveries = true
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.default_charset = "iso-8859-1"
  
  # yaml_contents = File.open("#{RAILS_ROOT}/config/mailer.yml")
  # mailer_options = YAML.load(yaml_contents)
  # config.action_mailer.smtp_settings = mailer_options
  config.load_paths += Dir["#{RAILS_ROOT}/vendor/gems/**"].map do |dir| 
    File.directory?(lib = "#{dir}/lib") ? lib : dir
  end
end

# Add new inflection rules using the following format 
# (all these examples are active by default):
# Inflector.inflections do |inflect|
#   inflect.plural /^(ox)$/i, '\1en'
#   inflect.singular /^(ox)en/i, '\1'
#   inflect.irregular 'person', 'people'
#   inflect.uncountable %w( fish sheep )
# end

# Add new mime types for use in respond_to blocks:
Mime::Type.register "text/richtext", :rtf
Mime::Type.register "application/x-mobile", :mobile
Mime::Type.register "text/csv", :csv
Mime::Type.register "application/vnd.ms-excel", :xls

# Include your application configuration below
ExceptionNotifier.exception_recipients = %w(gilles.apperrors@gmail.com) # pass : carmen30
# defaults to exception.notifier@default.com
ExceptionNotifier.sender_address = %("Application Error" <gilles@assogwada.kannida.com>)
# defaults to "[ERROR] "
ExceptionNotifier.email_prefix = "[ASSOGWADA]"