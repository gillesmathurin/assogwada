class Dispositif < ActiveRecord::Base
  has_many :regroupements,:dependent => :destroy
  has_many :associations, :through => :regroupements
  
  # Méthodes
  def self.select_array
    self.find(:all).collect { |d| [d.nom, d.id] }
  end
end
