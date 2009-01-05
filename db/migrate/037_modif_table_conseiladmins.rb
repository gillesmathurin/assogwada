class ModifTableConseiladmins < ActiveRecord::Migration
  def self.up
    remove_column :conseiladmins, :annee_dbt
    remove_column :conseiladmins, :annee_fin
  end

  def self.down
    add_column :conseiladmins, :annee_dbt,      :date
    add_column :conseiladmins, :annee_fin,      :date
  end
end
