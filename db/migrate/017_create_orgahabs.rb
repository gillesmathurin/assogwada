# -*- encoding : utf-8 -*-
class CreateOrgahabs < ActiveRecord::Migration
  def self.up
    create_table :orgahabs do |t|
      t.column :nom, :string
    end
  end

  def self.down
    drop_table :orgahabs
  end
end
