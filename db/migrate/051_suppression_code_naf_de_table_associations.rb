class SuppressionCodeNafDeTableAssociations < ActiveRecord::Migration
  def self.up
    remove_column :associations, :naf
  end

  def self.down
    add_column :associations, :naf, :string
  end
end
