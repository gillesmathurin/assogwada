class AssocManif < ActiveRecord::Base
  # Validations
  
  # Relations
  belongs_to :association
  belongs_to :manifestation
end
