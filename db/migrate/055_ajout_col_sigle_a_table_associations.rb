class AjoutColSigleATableAssociations < ActiveRecord::Migration
  def self.up
    add_column :associations, :sigle, :string
  end

  def self.down
    remove_column :associations, :sigle
  end
end
