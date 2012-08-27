# -*- encoding : utf-8 -*-
class AjoutSiretApeNafATableAssociations < ActiveRecord::Migration
  def self.up
    add_column :associations, :siret, :integer, :size => 13
    add_column :associations, :ape, :string, :size => 4
    add_column :associations, :naf, :string
  end

  def self.down
    remove_column :associations, :siret
    remove_column :associations, :ape
    remove_column :associations, :naf
  end
end
