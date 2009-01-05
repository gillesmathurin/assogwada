class Abonne < ActiveRecord::Base
  validates_presence_of :nom_abonne, :email_abonne, :on => :create, :message => "ne peut être vide"
  validates_uniqueness_of :email_abonne, :on => :create, :message => "cet adresse email est déjà enregistrée"
end
