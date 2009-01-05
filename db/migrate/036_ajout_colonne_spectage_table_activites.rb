class AjoutColonneSpectageTableActivites < ActiveRecord::Migration
  def self.up
    add_column :activites, :spectage, :string
  end

  def self.down
    remove_column :activites, :spectage
  end
end
