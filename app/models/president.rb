# -*- encoding : utf-8 -*-
class President < Membre
  # validations
  # validates_presence_of :nom, :prenom, :on => :create, :message => "can't be blank"
  # validates_format_of :email, :with => /^\w+@\w+\.\w{2,3}$/, :message => "e-mail invalide"
  # relations
  belongs_to :conseiladmin
  
  def nom_prenom
    nom_prenom = self.nom + " " + self.prenom
  end
end
