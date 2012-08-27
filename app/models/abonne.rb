# -*- encoding : utf-8 -*-
class Abonne < ActiveRecord::Base
  validates_presence_of :nom_abonne, :email_abonne, :on => :create, :message => "ne peut être vide"
  validates_format_of :email_abonne, :with => /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i,
   :on => :create, :message => "l'adresse email n'est pas valide"
  validates_uniqueness_of :email_abonne, :on => :create, :message => "cet adresse email est déjà enregistrée"
end
