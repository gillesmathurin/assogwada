class Recherch #< ActiveRecord::Base
  
  attr_accessor :keywords, :ville, :ci, :ci2, :activite, :manifestation, :blank_criterias
  
  def initialize(params = {})
    @criterias = params
    @keywords = params[:keywords]
    @ville = params[:ville]
    @ci = params[:ci]
    @ci2 = params[:ci2]
    @activite = params[:activite]
    @manifestation = params[:manifestation]
    if (@keywords.blank? && @ville.blank? && @ci.blank? && ci2.blank? && @activite.blank? && manifestation.blank?)
      @blank_criterias = true
    end
  end
  
  def associations
    unless @blank_criterias == true
      @associations = find_associations
    end
  end
 
  private
  
  def find_associations
    Association.find(:all, {:conditions => conditions, :include => [:champ_interventions, :activites, :manifestations]})
  end
  
  def keywords_conditions
    ["(associations.nom LIKE ? or associations.sigle LIKE ?)", "%#{@keywords}%", "%#{@keywords}%"] unless @keywords.blank?
  end
  
  def ville_conditions
    ["associations.ville = ?", @ville] unless @ville.blank?
  end
  
  def champinterv1_conditions
    ["(champ_interventions.nom = ? or champ_interventions.nom = ?)", @ci, @ci2] unless (@ci.blank? && @ci2.blank?)
  end
  
  # def champinterv2_conditions
  #   ["champ_interventions.nom = ?", @ci2] unless @ci2.blank?
  # end
  
  def activite_conditions
    ["activites.nom like ?", "%#{@activite}%" ] unless @activite.blank?
  end
  
  def manifestation_conditions
    ["manifestations.nom like ?", "%#{@manifestation}%" ] unless @manifestation.blank?
  end
  
  def state_conditions
    ["associations.state = ?", "acceptee"]
  end
  
  def conditions
    [conditions_clauses.join(' AND '), *conditions_options]
  end
  
  def conditions_clauses
    conditions_parts.map { |condition| condition.first }
  end
  
  def conditions_options
    conditions_parts.map { |condition| condition[1..-1] }.flatten
  end
  
  def conditions_parts
    private_methods(false).grep(/_conditions$/).map { |m| send(m) }.compact
  end
end
