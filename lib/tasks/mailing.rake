desc "Send Mailing"
task :send_mailing => :environment do
  @associations = []
  @resultats = (ENV["RESULTATS"].gsub(/'/, '')).to_a
  puts @resultats.class
  @mailing = Mailing.find(ENV["MAILING_ID"])

  if (@mailing.recipients.nil? && ( !@resultats.nil? || !@resultats.empty?) )
    @resultats.each do |id|
      association = Association.find(id)
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
  puts "task completed"  
end