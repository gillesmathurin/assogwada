desc "Send Mailing"
task :send_mailing => :environnment do
  @associations = []
  @mailing = Mailing.find(ENV["MAILING_ID"])
  if (@mailing.recipient.nil? && ( !session[:resultats].nil? || !session[:resultats].empty?))
    @resultats = session[:resultats]
    @resultats.each do |array|
      association = Association.find(array[0])
      @associations << association.email unless (association.email.empty? || association.email.nil?)
    end
    # stocke la liste des destinataires du mailing
    @mailing.update_attribute(:recipients, Marshal.dump(@associations))
    # délivre le mailing
    @mailing.deliver(@associations)
  elsif !@mailing.recipients.nil?
    # fetch the last recipients of this mailing 
    @associations = Marshal.load(@mailing.recipients)
    @mailing.deliver(@associations)
  end
end