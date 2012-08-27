# -*- encoding : utf-8 -*-
module ActivitesHelper
  def lien_ajout_planning(nom)
    link_to_function nom do |page|
			page.insert_html :bottom, :plannings, :partial => 'planning', :object => Planning.new
		end
  end
  
  def lien_ajout_interplanning(nom)
    link_to_function nom do |page|
			page.insert_html :bottom, :interplannings, :partial => 'inter_planning',
			 :object => InterPlanning.new(:stime => "", :etime => "", :lundi => 0, :mardi => 0,
       :mercredi => 0, :jeudi => 0, :vendredi => 0, :samedi => 0, :dimanche => 0)
		end
  end
end
