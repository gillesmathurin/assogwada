# -*- encoding : utf-8 -*-
class Salarie < ActiveRecord::Base
  # validations
  validates_presence_of :sexe, :poste,
   :on => :create, :message => "ne peut être vide"
   
  # relations
  belongs_to :association
  
  # Constantes
  SEXE = [["Masculin", "M"], ["Féminin","F"]]
  
  CONTRAT_CLASSIQUE = [ ["Professionalisation", "PF"],
   ["Contrat Nouvelle Embauche", "CNE"], ["CDI", "CDI"], ["CDD", "CDD"],
   ["CDI-Temps partiel", "CDI-TP"], ["CDD-Temps partiel", "CDD-TP"],
    ["Travail intérimaire", "TI"], ["Intermittant", "I"] ]
   
   # Méthode
   def contrat_class_to_str
    case self.contrat_classique
    when "PF"
      self.contrat_classique = "Professionalisation"
    when "CNE"
      self.contrat_classique = "Contrat Nouvelle Embauche"
    when "TP"
      self.contrat_classique = "Temps partiel"
    when "TI"
      self.contrat_classique = "Travail intérimaire"
    when "I"
      self.contrat_classique = "Intermittant"
    end
   end
   
   def sexe_to_str
    case self.sexe
    when "M"
      self.sexe = "Masculin"
    when "F"
      self.sexe = "Féminin"
    end
   end
end
