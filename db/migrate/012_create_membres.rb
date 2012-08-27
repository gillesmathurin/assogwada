# -*- encoding : utf-8 -*-
class CreateMembres < ActiveRecord::Migration
  def self.up
    create_table :membres do |t|
      # pour STI
      t.column :type, :string
      # attributs communs
      t.column :nom, :string
      t.column :prenom, :string
      t.column :telephone, :string
      t.column :mobile, :string
      t.column :fax, :string
      t.column :sexe, :string
      t.column :tranche_age, :string
      t.column :email, :string
      # specifique aux contacts
      t.column :is_contact, :boolean      
      t.column :dbt_presence, :time
      t.column :fin_presence, :time
      # specifique aux membres appartenant à un conseil d'administration
      t.column :conseiladmin_id, :integer
    end
  end

  def self.down
    drop_table :membres
  end
end
