# -*- encoding : utf-8 -*-
class Secretaire < Membre
  # validations
  # validates_presence_of :nom, :prenom, :message => "ne peut-être vide"
  # relations
  belongs_to :conseiladmin  
end
