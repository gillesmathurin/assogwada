# -*- encoding : utf-8 -*-
class Membre < ActiveRecord::Base
  # validations
  # validates_presence_of :nom, :prenom, :on => :create, :message => "ne peut être vide"
  # validates_format_of :email, :with => /^\w+@\w+\.\w{2,3}$/, :message => "e-mail invalide"
  # relations
  has_many :adhesions
  belongs_to :conseiladmin
  
  attr_accessor :should_destroy
  
  def should_destroy?
    should_destroy.to_i == 1
  end
  
  #### Constantes ###
  # Sexe
  SEXE = [["Masculin", "M"], ["Féminin", "F"]]
  
  # Tranches d'âge
  TRANCHE_AGE = [["-18", "-18"], ["18-25", "18-25"], ["25-60", "25-60"],
   ["+ 60", "+ 60"]]
  
  # methode de classe
  def self.only_membres
    find(:all, :conditions => {:type => nil})
  end
  
  def nom_prenom
    nom_prenom = self.nom + " " + self.prenom
  end
end
