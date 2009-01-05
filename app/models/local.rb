class Local < ActiveRecord::Base
  
  # validations
  # validates_presence_of :adresse, :cp, :ville, :message => "ne peut être vide"
  # validates_numericality_of :cp, :message => "doit être de la forme : 97180"
  # validates_format_of :cp, :with => /^\d{5,5}/, :on => :create, :message => "doit être de la forme : 97180"
  # validates_associated :planning_locals
  
  # Relations
  belongs_to :association, :counter_cache => true
  has_many :planning_locals
  
  after_update :save_plannings
  
    
  # Constantes
  JOURS = [ ["Lundi", "Lun"], ["Mardi", "Mar"], ["Mercredi", "Mer"], ["Jeudi", "Jeu"],
  ["Vendredi", "Ven"], ["Samedi", "Sam"], ["Dimanche", "Dim"] ]
 
  # construit des objets plannings en utilisant le modèle intermédiaire interplanning
  def interplanning_attributes=(interplanning_attributes)
    interplanning_attributes.each do |inter_planning|
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
          @planning = PlanningLocal.create(:jour => j, :hmat_debut => Time.parse(@ip.stime_mat),
           :hmat_fin => Time.parse(@ip.etime_mat))
           self.planning_locals << @planning
        elsif (@ip.stime_mat.blank? && !@ip.stime_apm.blank?)
          @planning = PlanningLocal.create(:jour => j, :hapm_debut => Time.parse(@ip.stime_apm),
           :hapm_fin => Time.parse(@ip.etime_apm))
           self.planning_locals << @planning
        elsif (!@ip.stime_mat.blank? && !@ip.stime_apm.blank?)
          @planning = PlanningLocal.create(:jour => j, :hmat_debut => Time.parse(@ip.stime_mat),
           :hmat_fin => Time.parse(@ip.etime_mat), :hapm_debut => Time.parse(@ip.stime_apm),
           :hapm_fin => Time.parse(@ip.etime_apm))
           self.planning_locals << @planning
        end
      end
    end
  end
      
  def planning_attributes=(planning_attributes)
    planning_attributes.each do |attributes|
      if attributes[:id].blank?
        self.planning_locals.build(attributes)
      else
        planning = planning_locals.detect { |p| p.id == attributes[:id].to_i }
        planning.attributes = attributes
      end
    end
  end
  
  def save_plannings
    planning_locals.each do |p|
      if p.should_destroy?
        p.destroy
      else
        p.save(false)
      end
    end
  end
end
