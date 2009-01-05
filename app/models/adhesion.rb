class Adhesion < ActiveRecord::Base
  # Validations
  validates_presence_of :association_id, :message => "ne peut être vide"
  validates_presence_of :membre_id, :message => "ne peut être vide"
  validates_numericality_of :association_id, :message => "doit être un entier"
  validates_numericality_of :membre_id, :message => "doit être un entier"
  # Relations
  belongs_to :association
  belongs_to :membre
end
