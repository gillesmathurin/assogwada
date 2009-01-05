class Manifestation < ActiveRecord::Base
  
  # Validations
  validates_presence_of :nom, :spectateur, :message => "ne peut être vide"
  validates_numericality_of :prix, :allow_nil => true
  validates_associated :planning_manifs

  # Relations
  has_many :assoc_manifs
  has_many :associations, :through => :assoc_manifs
  has_many :planning_manifs
  
  after_update :save_plannings
  
  # Constantes
  SPECTATEUR = [["Adhérent", "Adhérent"], ["Non-adhérent", "Non-adhérent"],
   ["Tout public", "Tout public"], ["Handicapés", "Handicapés"]]
  PUBLIC_AGE =  [["Tous Ages", "Tous Ages"],["- de 6 ans", "- de 6 ans"],
    ["6 à 12 ans", "6 à 12 ans"], ["Adulte", "Adulte"], ["Adolescent", "Adolescent"],
    ["Personnes agées", "Personnes agées"]]
  
  # Construction d'un tableau qui sera utiliser dans une liste de sélection 
  def self.select_array
    self.find(:all).collect { |m| [m.nom, m.id] }
  end
  
  # Reformatage pour meilleure lisibilité des types de spectateur (public)
  def spectateur_to_str
    case self.spectateur
    when "AD"
      self.spectateur = "Adhérent"
    when "NA"
      self.spectateur = "Non-adhérent"
    when "TP"
      self.spectateur = "Tout public"
    end
  end
  
  def spectage_to_str
    case self.spectage
    when "TA"
      self.spectage = "Tout Age"
    when "E"
      self.spectage = "Jeune"
    when "ADO"
      self.spectage = "Adolescent"
    when "A"
      self.spectage = "Adulte"
    when "PA"
      self.spectage = "Personnes agées"
    when "H"
      self.spectage = "Handicapés"
    end
  end
  
  def gratuit_to_str
    case self.gratuit
    when false
      self.gratuit = "Non"
    when true
      self.gratuit = "Oui"
    end
  end

  def new_planning_attributes=(planning_attributes)
    planning_attributes.each do |attributes|
      planning_manifs.build(attributes)
    end
  end

  def existing_planning_attributes=(planning_attributes)
    planning_manifs.reject(&:new_record?).each do |planning_manif|
      attributes = planning_attributes[planning_manif.id.to_s]
      if attributes
        planning_manifs.attributes = attributes
      else
        planning_manifs.delete(planning_manif)
      end
    end
  end
    
  # def planning_attributes=(planning_attributes)
  #   planning_attributes.each do |attributes|
  #     if attributes[:id].blank?
  #       self.planning_manifs.build(attributes)
  #     else
  #       planning = planning_manifs.detect { |p| p.id == attributes[:id].to_i }
  #       planning.attributes = attributes
  #     end
  #   end
  # end
  
  def save_plannings
    planning_manifs.each do |p|
      if p.should_destroy?
        p.destroy
      else
        p.save(false)
      end
    end
  end
end
