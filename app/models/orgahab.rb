# -*- encoding : utf-8 -*-
class Orgahab < ActiveRecord::Base
  # validations
  validates_presence_of :nom, :on => :create, :message => "can't be blank"
  # relations
  has_many :agrements
  has_many :associations, :through => :agrements
  has_many :conv_pluris
  
  def self.select_array
    self.find(:all).collect { |o| [o.nom, o.id] }
  end
  
end
