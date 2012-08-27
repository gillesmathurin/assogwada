# -*- encoding : utf-8 -*-
class AjoutNbTotalAdherentTableAssociations < ActiveRecord::Migration
  def self.up
    add_column :associations, :total_adherent, :integer
    add_column :associations, :part_subvention_prive, :integer
    rename_column :associations, :part_subventions, :part_subvention_public
  end

  def self.down
    remove_column :associations, :total_adherent
    remove_column :associations, :part_subvention_prive
    rename_column :associations, :part_subvention_public, :part_subventions
  end
end
