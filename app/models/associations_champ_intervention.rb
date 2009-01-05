class AssociationsChampIntervention < ActiveRecord::Base
  belongs_to :association
  belongs_to :champ_intervention
end
