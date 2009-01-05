class ChargementDonneesConventions < ActiveRecord::Migration
  def self.up
    @conventions = ["Aide ou maintien à domicile (Organismes d’)", "Animation",
      "Enseignement privé", "Entrepreneur de spectacle", "Entreprise artistique et culturelle",
      "Espaces de loisirs, d’attractions et culturels",
      "Etablissements et services sanitaires, sociaux et médico-sociaux",
      "Formation (Organismes de )",
      "Etablissements et services pour les personnes inadaptées et handicapées",
      "Organismes gestionnaires de foyers et services pour jeunes travailleurs",
      "Sport", "Tourisme social et familial", "Autre"]
      
    @conventions.each do |c|
      Convention.create(:nom => c)
    end
  end

  def self.down
    Convention.delete_all
  end
end
