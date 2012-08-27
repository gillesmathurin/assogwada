# -*- encoding : utf-8 -*-
class CreateNlContents < ActiveRecord::Migration
  def self.up
    create_table :nl_contents do |t|
      t.string :titre
      t.text :body
      t.integer :newsletter_id

      t.timestamps
    end
  end

  def self.down
    drop_table :nl_contents
  end
end
