class Agrement < ActiveRecord::Base
  # Validations
  validates_presence_of :nom, :message => "l'agrément doit avoir un nom"
  # Relations
  belongs_to :association
  belongs_to :orgahab
end
