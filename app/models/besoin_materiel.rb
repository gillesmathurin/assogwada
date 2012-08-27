# -*- encoding : utf-8 -*-
class BesoinMateriel < ActiveRecord::Base
  # Validations
  validates_presence_of :categorie, :desc, :quantite, :message => "ne peut être
   vide"
  validates_numericality_of :quantite, :message => "la quantite doit être un 
   chiffre entier"
  # Relations
  belongs_to :association
end
