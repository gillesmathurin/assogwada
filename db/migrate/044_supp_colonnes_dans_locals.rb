# -*- encoding : utf-8 -*-
class SuppColonnesDansLocals < ActiveRecord::Migration
  def self.up
    remove_column :locals, :jour_recep_debut
    remove_column :locals, :jour_recep_fin
    remove_column :locals, :h_recep_debut
    remove_column :locals, :h_recep_fin
  end

  def self.down
    add_column :locals, :jour_recep_debut, :string
    add_column :locals, :jour_recep_fin, :string
    add_column :locals, :h_recep_debut, :time
    add_column :locals, :h_recep_fin, :time
  end
end
