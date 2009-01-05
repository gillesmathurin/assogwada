class AjoutColonnesNomContactEtCoordonneesContactATableAssociations < ActiveRecord::Migration
  def self.up
    add_column :associations, :nom_contact, :string
    add_column :associations, :coordonnees_contact, :string
  end

  def self.down
    remove_column :associations, :nom_contact
    remove_column :associations, :coordonnees_contact
  end
end
