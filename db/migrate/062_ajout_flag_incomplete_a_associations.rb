class AjoutFlagIncompleteAAssociations < ActiveRecord::Migration
  def self.up
    add_column :associations, :incomplete, :boolean
  end

  def self.down
    remove_column :associations, :incomplete
  end
end
