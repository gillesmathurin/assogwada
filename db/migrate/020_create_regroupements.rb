class CreateRegroupements < ActiveRecord::Migration
  def self.up
    create_table :regroupements do |t|
      t.column :association_id, :integer
      t.column :fedeRgptDispoConv_id, :integer
    end
  end

  def self.down
    drop_table :regroupements
  end
end
