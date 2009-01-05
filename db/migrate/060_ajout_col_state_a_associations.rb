class AjoutColStateAAssociations < ActiveRecord::Migration
  def self.up
    add_column :associations, :state, :string
  end

  def self.down
    remove_column :associations, :state
  end
end
