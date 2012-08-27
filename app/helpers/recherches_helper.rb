# -*- encoding : utf-8 -*-
module RecherchesHelper
  
  def hidden_div_if(condition, attributes = {}, &block)
    if condition
      attributes["style"] = "display:none"
    end
    content_tag("div", attributes, &block)
  end

  def planning_absent?(planning)
    if planning.jour.nil? || planning.hmat_debut.nil? || planning.hapm_fin.nil? 
      return true
    else
      return false
    end
  end
  
  def has_email?(association)
    unless association.email.blank?
      mail_to @association.email, "Adressez nous un email", :encode => "hex"
    end
  end
  
  def has_website?(association)
    # CHANGED : check if the website_url starts with "http://" or not
    # TODO : check if the website_url is internal or external
    if !association.website_url.blank? && association.website_url.starts_with?("http://")
      link_to association.website_url, "#{association.website_url}"
    elsif !association.website_url.blank? && !association.website_url.starts_with?("http://")
      link_to association.website_url, "http://#{association.website_url}"
    end
  end
  
  def has_sigle?(association)
    unless association.sigle.blank?
      @association.sigle
    end
  end
  
  def objet_social_or_cis(association)
    if association.objet_social.blank?
      render :partial => 'champ_interventions', :object => association
    else
      association.objet_social
    end
  end
  
  def objet_or_cis(association)
    unless association.objet_social.blank?
      "Objet Social"
    else
      "Champs d'intervention"
    end
  end
end
