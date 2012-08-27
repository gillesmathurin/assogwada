# -*- encoding : utf-8 -*-
class CreateManifestations < ActiveRecord::Migration
  def self.up
    create_table :manifestations do |t|
      t.column :nom, :string
      t.column :date, :date
      t.column :h_dbt, :time
      t.column :h_fin, :time
      t.column :public, :string
      t.column :prix, :integer
      t.column :modalite_inscription, :text
      t.column :infos_sup, :text
    end
  end

  def self.down
    drop_table :manifestations
  end
end
