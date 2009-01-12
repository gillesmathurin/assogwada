desc "Send Mailing"
task :send_mailing => :environnment do
  @associations = []
  unless (session[:resultats].nil? || session[:resultats].empty?)
    @resultats = session[:resultats]
    @resultats.each do |array|
      association = Association.find(array[0])
      @associations << association.email unless association.email.empty?
    end
    @mailing = Mailing.find(ENV["MAILING_ID"])
    @mailing.deliver(@associations)
  end
end