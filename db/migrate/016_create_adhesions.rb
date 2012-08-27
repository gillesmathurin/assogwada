# -*- encoding : utf-8 -*-
class CreateAdhesions < ActiveRecord::Migration
  def self.up
    create_table :adhesions do |t|
      t.column :association_id, :integer, :null => false
      t.column :membre_id, :integer, :null => false
    end
  end

  def self.down
    drop_table :adhesions
  end
end
