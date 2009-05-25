desc "Send Mailing"
task :send_mailing => :environment do
  logger = Logger.new("#{RAILS_ROOT}/log/rake.log")
  @associations = []
  ids = []
  
  if ENV["RESULTATS"]
    ENV["RESULTATS"].gsub(/\w+/) { |id| ids << id }
  end
  logger.info("Liste 'ids' des id récupéré : #{ids.inspect} et classe 'ids' : #{ids.class}")
  
  @mailing = Mailing.find(ENV["MAILING_ID"])

  if (@mailing.recipients.nil? && !ids.empty?)
    ids.each do |id|
      association = Association.find(id)
      unless (association.email.blank? || association.email.nil? || association.state != "acceptee")
        @associations << association.email
      end
    end
    
    logger.info("Liste des emails #{@associations.inspect}")
    recipients = Marshal.dump(@associations)
    
    # stocke la liste des destinataires du mailing
    @mailing.update_attribute(:recipients, recipients)
    # délivre le mailing
    @mailing.deliver(@associations)
  elsif !@mailing.recipients.nil?
    # fetch the last recipients of this mailing 
    @associations = Marshal.load(@mailing.recipients)
    @mailing.deliver(@associations)
  end
end