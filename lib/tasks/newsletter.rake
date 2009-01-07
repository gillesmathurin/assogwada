desc "Send Newsletter"
task :send_newsletter => :environment do
  @abonnes = Abonne.all(:select => :email_abonne)
  @newletter = Newsletter.find(ENV["NEWSLETTER_ID"])
  @newsletter.deliver
end