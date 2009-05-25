desc  "Search and Mark Association with bad emails"
task :locate_associations => :environment do
  
  @associations = Association.find(:all)
  regex = /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i
  logger = Logger.new("#{RAILS_ROOT}/log/rake.log")
  
  @associations.each do |asso|
    if !asso.email.blank? && regex.match(asso.email).to_s == "" 
        logger.info("Nom Association : #{asso.nom} | Email : #{asso.email}")
    end
  end
  
end