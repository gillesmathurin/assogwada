# -*- encoding : utf-8 -*-
class CreateNewsletters < ActiveRecord::Migration
  def self.up
    create_table :newsletters do |t|
      t.datetime :date_pub

      t.timestamps
    end
  end

  def self.down
    drop_table :newsletters
  end
end
