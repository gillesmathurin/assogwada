class Association < ActiveRecord::Base
  @@callback_after_find = true
  attr_reader :callback_after_find
  
  # Validations
  validates_presence_of :nom, :adresse_siegesocial, :ville
  # cotisation_annuelle doit être mis en commentaire pour bon déroulement du data-migration
  validates_associated :champ_interventions
  validates_format_of :email, :email2, :with => /^[\w\.%\+\-]+@(?:[A-Z0-9\-]+\.)+(?:[A-Z]{2}|com|org|net|edu|gov|mil|biz|info|mobi|name|aero|jobs|museum|fr)\z/i , :on => :create, :message => "non valide"
  
  before_validation_on_create :set_permalink
  
  # def after_validation
  #   # Iterate through the errors
  #   errors.each do |field,message|
  #     # If the field of an error is really an association, then the 'validates_associated' found an error
  #     if self.class.reflect_on_all_associations.collect(&:name).index(field.to_sym)
  #       # Iterate through the objects in the association looking for the invalid ones
  #       for association in [self.send(field)].flatten
  #         if association and !association.valid?
  #           # add the error messages of the associated object to my error messages
  #           association.errors.each_full do |msg|
  #             self.errors.add_to_base msg
  #           end
  #         end
  #       end
  #     end
  #   end
  # end
  
  # Relations
  has_one :conseiladmin
  has_many :agrements
  has_many :orgahabs, :through => :agrements
  has_many :locals
  has_many :adhesions
  has_many :membres, :through => :adhesions
  has_many :regroupements, :dependent => :destroy
  has_many :dispositifs, :through => :regroupements
  has_many :activites
  has_many :assoc_manifs
  has_many :manifestations, :through => :assoc_manifs
  has_many :besoin_materiels
  has_many :besoin_humains
  has_many :salaries, :class_name => "Salarie", :foreign_key => "association_id"
  has_many :associations_champ_interventions, :dependent => :destroy
  has_many :champ_interventions, :through => :associations_champ_interventions
  has_many :conv_pluris
  belongs_to :convention
  
  acts_as_state_machine :initial => :non_verifiee
  state :non_verifiee
  state :rejetee
  state :acceptee
  state :suspendue
  state :reactivee
  
  event :accept do
    transitions :from => :non_verifiee, :to => :acceptee
  end
  
  event :reject do
    transitions :from => :non_verifiee, :to => :rejetee
    transitions :from => :acceptee, :to => :rejetee
  end
  
  event :suspend do
    transitions :from => :acceptee, :to => :suspendue
  end
  
  event :unsuspend do
    transitions :from => :suspendue, :to => :acceptee
  end
  
  attr_accessor :inscription_cis
  
  def cp_ville
    code_postal + " " + ville
  end
  
  # Constantes
  CHIFFRE_AFFAIRE = [["- 5000 € à 5000 €", "- 5000 -- 5000"],
   ["5000 € à 20 000 €", "5000 -- 20 000"], ["20 000 € à 50 000 €", "20 000 -- 50 000"],
   ["50 000 € à 100 000 €", "50 000 -- 100 000 "], ["+ 100 000 €", "+ 100 000"]]
   
  # Liste Communes  
  CODE_POSTAL = ["97139", "97121",
    "97122", "97123", "97100",
    "97125", "97130", "97140",
    "97126", "97127", "97190", "97113",
    "97128", "97112", "97129",
    "97111", "97160", "97170",
    "97131", "97110", "97116",
    "97117", "97180", "97133",
    "97120", "97118", "97134",
    "97150", "97115", "97136",
    "97137", "97114", "97141",
    "97119"]
    
  # Liste des Communes
  VILLE = ["Abymes (Les)", "Anse-Bertrand",
    "Baie-Mahault", "Baillif", "Basse-Terre",
    "Bouillante", "Capesterre Belle Eau", "Capesterre de Marie Galante",
    "Deshaies", "Désirade (La)", "Gosier (Le)", "Gourbeyre",
    "Goyave", "Grand Bourg", "Lamentin",
    "Morne à L'Eau", "Moule (Le)", "Petit Bourg",
    "Petit-Canal", "Pointe à Pitre", "Pointe Noire",
    "Port Louis", "Sainte Anne", "Saint Barthélémy",
    "Saint Claude", "Saint François", "Saint Louis",
    "Saint Martin", "Sainte Rose", "Terre de Bas",
    "Terre de Haut", "Trois rivières", "Vieux Fort",
    "Vieux Habitants"]
    
  # @@deactivate_callback = false
       
  # Methode public
  
  def to_param
    "#{id}-#{permalink}"
  end
  
  # def after_find
  #   return unless @@deactivate_callback
  #   if self.permalink.blank?
  #     self.permalink = self.nom.downcase.gsub(/\s+/, '_').gsub(/[^a-zA-z0-9_]+/, '')
  #     self.save!
  #   end
  # end
  
  # crée une liste de sélection 
  def self.select_array
    self.find(:all).collect { |a| [a.nom, a.id] }
  end
  
  # transforme en Oui ou Non le boolean de l'attribut est_employeur
  def employeur_to_str
    if self.est_employeur == false
      self.est_employeur = "Non"
    elsif self.est_employeur == true
      self.est_employeur = "Oui"
    end
  end
    
  # trouve les associations d'une ville donnée classée par nom 
  def self.find_by_commune(ville)
    find(:all, :conditions => ["associations.ville = ? AND associations.state = ?", ville, "acceptee"],
     :include => :champ_interventions, :order => "associations.nom ASC")
  end
  
  #trouve la dernière association référencée
  def self.last_recorded
    find(:first, :order => "created_at DESC", :limit => 1)
  end
  
  # retrouve les assocations non encore validée par l'administrateur
  def self.to_verify
    find(:all, :conditions => ['state = ?', "non_verifiee"], :order => "created_at DESC")
  end
  
  # retrouve les associations incompletes et les marque comme tel en mettant à jour leur champ 'incomplete'
  def self.mark_incomplete
    selected_array = []
    initial_array = find(:all)
    initial_array.each do |asso|
      if asso.conseiladmin.nil? || asso.locals.empty? || asso.nom_contact.blank? || asso.coordonnees_contact.blank? || asso.activites.empty?
        asso.update_attribute('incomplete', true)
        selected_array << asso
      end
    end
    return selected_array
  end
  
  # retrouve les associations 
  def self.incomplete
    find(:all, :conditions => ['incomplete = ? or activites_count = ? or locals_count = ? or conseiladmins_count = ? or nom_contact = ? or coordonnees_contact = ?', true,0,0,0,"",""])
  end
  
  def export_adress
    code_postal + " " + ville
  end

  protected
  
  def set_permalink
    self.permalink = self.nom.downcase.gsub(/\s+/, '_').gsub(/[^a-zA-z0-9_]+/, '')
  end

  
end
