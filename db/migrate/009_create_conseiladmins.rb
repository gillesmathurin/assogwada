class CreateConseiladmins < ActiveRecord::Migration
  def self.up
    create_table :conseiladmins do |t|
      t.column :annee_dbt, :date
      t.column :annee_fin, :date
      t.column :association_id, :integer
    end
  end

  def self.down
    drop_table :conseiladmins
  end
end
