class ModifPlanningsTable < ActiveRecord::Migration
  def self.up
    add_column :plannings, :type, :string
    add_column :plannings, :date, :date
    add_column :plannings, :manifestation_id, :integer
  end

  def self.down
    remove_column :plannings, :type
    remove_column :plannings, :date
    remove_column :plannings, :manifestation_id
  end
end
