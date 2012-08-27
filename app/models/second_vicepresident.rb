# -*- encoding : utf-8 -*-
class SecondVicepresident < Membre
  # validations
  # validates_presence_of :nom, :prenom, :message => "ne peut-être vide"
  # relations
  belongs_to :conseiladmin  
end
