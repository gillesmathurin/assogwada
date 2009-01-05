class BesoinHumain < ActiveRecord::Base
    
  # Validations
  validates_presence_of :categorie, :message => "vous devez choisir une catégorie
  de besoin"
  validates_presence_of :quantite, :message => "veuillez indiquer une quantité"
  validates_numericality_of :quantite, :message => "la quantité doit être un chiffre entier"
  
  # Relations
  belongs_to :association
end
