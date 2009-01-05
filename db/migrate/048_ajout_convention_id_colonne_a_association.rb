class AjoutConventionIdColonneAAssociation < ActiveRecord::Migration
  def self.up
    add_column :associations, :convention_id, :integer
    add_column :associations, :app_conv, :boolean
  end

  def self.down
    remove_column :associations, :convention_id
    remove_column :associations, :app_conv
  end
end
