class CreateNewsletters < ActiveRecord::Migration
  def self.up
    create_table :newsletters do |t|
      t.date :date_pub
      t.integer :numero

      t.timestamps
    end
  end

  def self.down
    drop_table :newsletters
  end
end
