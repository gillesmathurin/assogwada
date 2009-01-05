class AddDateCreationColumnToAssociationsTable < ActiveRecord::Migration
  def self.up
    add_column :associations, :date_creation, :date
  end

  def self.down
    remove_column :associations, :date_creation
  end
end
