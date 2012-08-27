# -*- encoding : utf-8 -*-
class PlanningLocal < Planning
  belongs_to :local
  attr_accessor :should_destroy
  
  def should_destroy?
    should_destroy.to_i == 1
  end
  
end
