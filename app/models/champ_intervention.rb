# -*- encoding : utf-8 -*-
class ChampIntervention < ActiveRecord::Base  
  # Validation 
  validates_presence_of :nom, :message => "veuillez indiquer le nom du champ
   d'intervention"   
   
  # Relation
  has_many :associations_champ_interventions
  has_many :associations, :through => :associations_champ_interventions
  
  # Construit le tableau qui sera utiliser avec l'helper select_tag
  def self.select_array()
    self.find(:all, :order => "nom asc").collect { |ci| [ci.nom, ci.id] }
  end
  
  def self.select_array_nom()
    self.find(:all, :order => "nom asc").collect { |ci| [ci.nom] }
  end
  
end
