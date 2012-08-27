# -*- encoding : utf-8 -*-
class Activite < ActiveRecord::Base
  
  # Validations
  validates_presence_of :nom, :message => "ne peut être vide"
  validates_numericality_of :tarif_mensuel, :licence, :allow_blank => true
  
  # Relations
  belongs_to :association, :counter_cache => true
  has_many :plannings, :dependent => :destroy
  
  after_update :save_plannings
        
  # Constantes
  PUBLIC = [["Adhérent", "Adhérent"], ["Non-adhérent", "Non-adhérent"],
   ["Tout public", "Tout public"], ["Handicapés", "Handicapés"]]
  PUBLIC_AGE = [["Tous Ages", "Tous Ages"],["- de 6 ans", "- de 6 ans"],
   ["6 à 12 ans", "6 à 12 ans"], ["Adulte", "Adulte"], ["Adolescent", "Adolescent"],
   ["Personnes agées", "Personnes agées"]]

  def besoin_habilitation_to_str
    case self.besoin_habilitation
    when true
      self.besoin_habilitation = "OUI"
    when false
      self.besoin_habilitation = "NON"
    end
  end
  
  # construit des objets plannings en utilisant le modèle intermédiaire interplanning
  def interplanning_attributes=(iplanning_attributes)
    iplanning_attributes.each do |inter_planning|
      # recupère les paramètres de l'instance pour créer un nouvel objet inter_planning
      @ip = InterPlanning.new(inter_planning.at(1))
      array = []
      # renseigne l'attribut jour de l'objet inter_planning avec le nom des jours cochés
      InterPlanning::DAYS.each do |j|
        iv = "@"+j
        if @ip.instance_variable_get(iv) == "1" || @ip.instance_variable_get(iv) == 1
          array << j
        end
      end
      @ip.jours = array
      # construit les objets Planning à partir des données de l'objet interplanning
      @ip.jours.each do |j|
        # CHANGE : gérer les cas ou les attributs d'horaires sont nuls ou vide (blank)
        if (!@ip.stime_mat.blank? && @ip.stime_apm.blank?)
          @planning = Planning.create(:jour => j, :hmat_debut => Time.parse(@ip.stime_mat),
           :hmat_fin => Time.parse(@ip.etime_mat))
           self.plannings << @planning
        elsif (@ip.stime_mat.blank? && !@ip.stime_apm.blank?)
          @planning = Planning.create(:jour => j, :hapm_debut => Time.parse(@ip.stime_apm),
           :hapm_fin => Time.parse(@ip.etime_apm))
           self.plannings << @planning
        elsif (!@ip.stime_mat.blank? && !@ip.stime_apm.blank?)
          @planning = Planning.create(:jour => j, :hmat_debut => Time.parse(@ip.stime_mat),
           :hmat_fin => Time.parse(@ip.etime_mat), :hapm_debut => Time.parse(@ip.stime_apm),
           :hapm_fin => Time.parse(@ip.etime_apm))
           self.plannings << @planning
        end
      end
    end
  end
  
  def planning_attributes=(planning_attributes)
    planning_attributes.each do |attributes|
      if attributes[:id].blank?
        self.plannings.build(attributes)
      else
        planning = plannings.detect { |p| p.id == attributes[:id].to_i }
        planning.attributes = attributes
      end
    end
  end
  
  def save_plannings
    plannings.each do |p|
      if p.should_destroy?
        p.destroy
      else
        p.save(false)
      end
    end
  end
end
