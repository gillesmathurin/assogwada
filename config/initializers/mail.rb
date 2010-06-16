# ActionMailer::Base.delivery_method = :smtp
# ActionMailer::Base.smtp_settings = { 
#   :address => "mail.asso-guadeloupe.fr", 
#   :port => 25, 
#   :domain => "asso-guadeloupe.fr",
#   :authentication => :login, 
#   :user_name => "gilles+asso-guadeloupe.fr", 
#   :password => "$rv+&c77ul&9"
# }
# ActionMailer::Base.perform_deliveries = true
# ActionMailer::Base.raise_delivery_errors = true
# ActionMailer::Base.default_charset = "iso-8859-1"

ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = { 
  :address => "smtp.gmail.com", 
  :port => 587, 
  # :domain => "repriz-cmdtp.org",
  :authentication => :plain,
  :enable_starttls_auto => true, 
  :user_name => "gwadaman30@gmail.com", 
  :password => "carmen30"
}
ActionMailer::Base.perform_deliveries = true
ActionMailer::Base.raise_delivery_errors = true
ActionMailer::Base.default_charset = "iso-8859-1"