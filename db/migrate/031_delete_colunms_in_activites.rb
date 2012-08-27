# -*- encoding : utf-8 -*-
class DeleteColunmsInActivites < ActiveRecord::Migration
  def self.up
    remove_column :activites, :jour
    remove_column :activites, :h_dbt
    remove_column :activites, :h_fin
  end

  def self.down
    add_column :activites, :h_dbt,     :time
    add_column :activites, :h_fin,                :time
    add_column :activites, :jour,                 :string
  end
end
