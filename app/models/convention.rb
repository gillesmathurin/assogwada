class Convention < ActiveRecord::Base
  has_many :associations
  
  def self.select_array
    self.find(:all).collect { |c| [c.nom, c.id] }
  end
end
