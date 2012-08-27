# -*- encoding : utf-8 -*-
class CreateQuests < ActiveRecord::Migration
  def self.up
    create_table :quests do |t|
      t.string :nom
      t.string :nom_asso
      t.string :file_url
      t.string :content_type
      t.string :filename

      t.timestamps
    end
  end

  def self.down
    drop_table :quests
  end
end
