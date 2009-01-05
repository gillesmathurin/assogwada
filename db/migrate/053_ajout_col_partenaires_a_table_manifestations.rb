class AjoutColPartenairesATableManifestations < ActiveRecord::Migration
  def self.up
    add_column :manifestations, :partenaires, :text
  end

  def self.down
    remove_column :manifestations, :partenaires
  end
end
