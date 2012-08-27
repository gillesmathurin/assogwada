# -*- encoding : utf-8 -*-
class CreateAgrements < ActiveRecord::Migration
  def self.up
    create_table :agrements do |t|
      t.column :association_id, :integer
      t.column :orgahab_id, :integer
      t.column :nom, :string
    end
  end

  def self.down
    drop_table :agrements
  end
end
