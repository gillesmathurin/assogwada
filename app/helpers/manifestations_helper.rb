# -*- encoding : utf-8 -*-
module ManifestationsHelper
  def ajout_planning_manif(nom)
    link_to_function nom do |page|
			page.insert_html :bottom, :planning_manifs, :partial => 'planning',
			 :object => PlanningManif.new
		end
  end
  
  def fields_for_planning(planning, &block)
    prefix = planning.new_record? ? 'new' : 'existing'
    fields_for("manifestation[#{prefix}_planning_attributes][]", planning, &block)
  end
  
  def lien_ajout_interplanning(nom)
    link_to_function nom do |page|
			page.insert_html :bottom, :interplannings, :partial => 'inter_planning',
			 :object => InterPlanning.new(:stime => "", :etime => "", :lundi => 0, :mardi => 0,
       :mercredi => 0, :jeudi => 0, :vendredi => 0, :samedi => 0, :dimanche => 0)
		end
  end
end
