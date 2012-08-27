# -*- encoding : utf-8 -*-
class Conseiladmin < ActiveRecord::Base
  # Validations
  # validates_presence_of :annee_dbt, :annee_fin
  # Relations
  belongs_to :association, :counter_cache => true
  has_one :president
  has_one :premier_vicepresident
  has_one :second_vicepresident
  has_one :tresorier
  has_one :tresorier_adjoint
  has_one :secretaire
  has_one :secretaire_adjoint
  has_many :membres
  
  after_update :save_membres
    
  def membre_attributes=(membre_attributes)
    membre_attributes.each do |attributes|
      if attributes[:id].blank?
        self.membres.build(attributes)
      else
        membre = membres.detect { |m| m.id == attributes[:id].to_i }
        membre.attributes = attributes
      end
    end
  end
  
  def save_membres
    membres.each do |m|
      if m.should_destroy?
        m.destroy
      else
        m.save(false)
      end
    end
  end
    
end
