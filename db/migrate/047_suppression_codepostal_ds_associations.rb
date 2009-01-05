class SuppressionCodepostalDsAssociations < ActiveRecord::Migration
  def self.up
    remove_column :associations, :cp
  end

  def self.down
    add_column :associations, :cp, :integer
  end
end
