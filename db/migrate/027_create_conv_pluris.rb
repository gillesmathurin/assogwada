# -*- encoding : utf-8 -*-
class CreateConvPluris < ActiveRecord::Migration
  def self.up
    create_table :conv_pluris do |t|
      t.column :association_id, :integer
      t.column :orgahab_id, :integer
    end
  end

  def self.down
    drop_table :conv_pluris
  end
end
