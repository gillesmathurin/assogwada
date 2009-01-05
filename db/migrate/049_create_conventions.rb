class CreateConventions < ActiveRecord::Migration
  def self.up
    create_table :conventions do |t|
      t.column :nom, :string
    end
  end

  def self.down
    drop_table :conventions
  end
end
