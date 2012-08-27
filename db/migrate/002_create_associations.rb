# -*- encoding : utf-8 -*-
class CreateAssociations < ActiveRecord::Migration
  def self.up
    create_table :associations do |t|
      t.column :nom, :string
      t.column :adresse_siegesocial, :string
      t.column :cp, :integer
      t.column :ville, :string
      t.column :telephone, :string
      t.column :fax, :string
      t.column :email, :string
      t.column :website_url, :string
      t.column :objet_social, :text
      t.column :cotisation, :decimal
      t.column :droit_entree, :decimal
      t.column :nb_adherent_homme, :integer
      t.column :nb_adherent_femme, :integer
      t.column :nb_adherent_enfant, :integer
      t.column :nb_adherent_adulte, :integer
      t.column :est_employeur, :boolean
      t.column :chiffre_affaire, :string
      t.column :part_ressource_propre, :integer
      t.column :part_subventions, :integer
      t.column :pcent_subvrecu_subvsoll, :integer
      t.column :created_at, :datetime
      t.column :motivation_creation, :text
    end
  end

  def self.down
    drop_table :associations
  end
end
