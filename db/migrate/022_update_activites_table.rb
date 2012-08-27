# -*- encoding : utf-8 -*-
class UpdateActivitesTable < ActiveRecord::Migration
  def self.up
    rename_column :associations, :cotisation, :cotisation_annuelle
    add_column :activites, :licence, :decimal, :precision => 8, :scale => 2
  end

  def self.down
    rename_column :associations, :cotisation_annuelle, :cotisation
    remove_column :activites, :licence
  end
end
