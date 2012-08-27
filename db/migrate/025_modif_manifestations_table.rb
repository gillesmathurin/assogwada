# -*- encoding : utf-8 -*-
class ModifManifestationsTable < ActiveRecord::Migration
  def self.up
    add_column :manifestations, :lieu, :string
    add_column :manifestations, :nature, :string
    add_column :manifestations, :lieu_inscription, :string
    add_column :manifestations, :nom_resp, :string
    add_column :manifestations, :coordonees, :string
    add_column :manifestations, :gratuit, :boolean, :default => false
    rename_column :manifestations, :public, :spectateur
  end

  def self.down
    remove_column :manifestations, :lieu
    remove_column :manifestations, :nature
    remove_column :manifestations, :lieu_inscription
    remove_column :manifestations, :nom_resp
    remove_column :manifestations, :coordonees
    remove_column :manifestations, :gratuit
    rename_column :manifestations, :spectateur, :public
  end
end
