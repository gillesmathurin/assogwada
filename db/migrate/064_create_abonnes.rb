# -*- encoding : utf-8 -*-
class CreateAbonnes < ActiveRecord::Migration
  def self.up
    create_table :abonnes do |t|
      t.string :nom_abonne
      t.string :email_abonne

      t.timestamps
    end
  end

  def self.down
    drop_table :abonnes
  end
end
