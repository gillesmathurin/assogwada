class AjoutCounterColumnsAAssociations < ActiveRecord::Migration
  def self.up
    add_column :associations, :locals_count, :integer, :default => 0
    add_column :associations, :activites_count, :integer, :default => 0
    add_column :associations, :conseiladmins_count, :integer, :default => 0
  end

  def self.down
    remove_column :associations, :conseiladmins_count
    remove_column :associations, :activites_count
    remove_column :associations, :locals_count
  end
end
