# -*- encoding : utf-8 -*-
module AssociationsHelper
  # def ajout_champ_intervention(nom)
  #    link_to_function nom do |page|
  #       page.insert_html :bottom, :champs, :partial => 'champ_inter',
  #        :object => ChampIntervention.new
  #     end
  #  end
  
  def index_ci(index)
    if index.to_i == 0
      return index.to_i
    else
      return index.to_i
    end
  end
  
  # affiche le lien d'action en fonction de l'attribut "state" (du statut) de l'association dans la BDD
  def possible_state_link(association)
    case association.state
    when "non_verifiee"
      link_to "Valider", accept_association_path(association), :method => :put
    when "acceptee"
      link_to "Suspendre", suspend_association_path(association), :method => :put
    when "suspendue"
      link_to "Ré-activer", unsuspend_association_path(association), :method => :put
    end
  end
  
  def validation_links(number)
    unless number == 0
          link_to( "Voir Liste", verify_associations_path) + "<br/>" + link_to( "Retour Listing complet", associations_path)
    end
  end
  
  # def validation_links(number)
  #   unless number == 0
  #     content_tag(:ul) do |x|
  #       x = ""
  #       x += content_tag(:li, link_to( "Voir Liste", verify_associations_path))
  #       x += content_tag(:li, link_to( "Retour Listing complet", associations_path))
  #     end
  #   end
  # end
end
