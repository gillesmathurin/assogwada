# -*- encoding : utf-8 -*-
class CreatePlannings < ActiveRecord::Migration
  def self.up
    create_table :plannings do |t|
      t.column :jour, :string
      t.column :h_debut, :time
      t.column :h_fin, :time
      t.column :activite_id, :integer
    end
  end

  def self.down
    drop_table :plannings
  end
end
