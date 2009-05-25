desc "Send Newsletter"
task :send_newsletter => :environment do
  @abonnes = Abonne.find(:all, :select => :email_abonne)
  @newsletter = Newsletter.find(ENV["NEWSLETTER_ID"])
  @newsletter.deliver(@abonnes)
end