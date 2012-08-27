# -*- encoding : utf-8 -*-
class AssociationsChampIntervention < ActiveRecord::Base
  belongs_to :association
  belongs_to :champ_intervention
end
