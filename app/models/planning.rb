# -*- encoding : utf-8 -*-
class Planning < ActiveRecord::Base
  belongs_to :activite
  attr_accessor :should_destroy
  
  def should_destroy?
    should_destroy.to_i == 1
  end

  # Constantes
  JOURS = ["lundi", "mardi", "mercredi", "jeudi", "vendredi", "samedi", "dimanche"]
    
  # retourne les plannings triés par jour du lundi au dimanche
  def self.in_day_order
    a1 = self.find(:all, :order => "jour")
    a2 = a1.clone
    if a1[0].jour == "jeudi" && (a1.last.jour != "mercredi" ||
       a1.last.jour != "mardi" || a1.last.jour != "lundi")
      a1.insert(a1.index(a1.last), a2[0])
      a1.delete_at(0)
      return a1
    else
      return a1
    end
  end
end
