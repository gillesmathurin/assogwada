class CreateMailings < ActiveRecord::Migration
  def self.up
    create_table :mailings do |t|
      t.string :objet
      t.text :body
      t.datetime :published_at

      t.timestamps
    end
  end

  def self.down
    drop_table :mailings
  end
end
