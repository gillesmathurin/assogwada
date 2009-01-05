class AjoutColTarifParSeanceATableActivites < ActiveRecord::Migration
  def self.up
    add_column :activites, :tarif_seance, :string
  end

  def self.down
    remove_column :activites, :tarif_seance
  end
end
