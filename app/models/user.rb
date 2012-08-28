# -*- encoding : utf-8 -*-
require 'digest/sha1'
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :encryptable, :encryptor => :restful_authentication_sha1

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :login
  
  # prevents a user from submitting a crafted form that bypasses activation
  # anything else you want your user to change should be added here.
  attr_accessible :login, :email, :password, :password_confirmation
  
  # after_filter qui empêche la suppression du dernier Administrateur
  # after_destroy :verif_nb_admin
  
  protected
    
    # after filter qui empêche la suppression du dernier Administrateur
    def verif_nb_admin
      if User.find(:all, :conditions => ["categorie = ?", "1"]).size.zero?
        raise "Vous ne pouvez supprimer le dernier Administrateur"
      end
    end
end
