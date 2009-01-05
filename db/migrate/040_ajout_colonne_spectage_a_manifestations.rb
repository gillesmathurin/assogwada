class AjoutColonneSpectageAManifestations < ActiveRecord::Migration
  def self.up
    add_column :manifestations, :spectage, :string
  end

  def self.down
    remove_column :manifestations, :spectage
  end
end
