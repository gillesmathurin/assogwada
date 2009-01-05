class Modif2ManifestationsTable < ActiveRecord::Migration
  def self.up
    remove_column :manifestations, :date
    remove_column :manifestations, :h_dbt
    remove_column :manifestations, :h_fin
  end

  def self.down
    add_column :manifestations, :date,                 :date
    add_column :manifestations, :h_dbt,                :time
    add_column :manifestations, :h_fin,                :time
  end
end
