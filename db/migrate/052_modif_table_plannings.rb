class ModifTablePlannings < ActiveRecord::Migration
  def self.up
    rename_column :plannings, :h_debut, :hmat_debut
    rename_column :plannings, :h_fin, :hmat_fin 
    add_column :plannings, :hapm_debut, :time
    add_column :plannings, :hapm_fin, :time
  end

  def self.down
    rename_column :plannings, :hmat_debut, :h_debut
    rename_column :plannings, :hmat_fin, :h_fin
    remove_column :plannings, :hapm_debut
    remove_column :plannings, :hapm_fin
  end
end
