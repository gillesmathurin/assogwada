class CreateAssocManifs < ActiveRecord::Migration
  def self.up
    create_table :assoc_manifs do |t|
      t.column :association_id, :integer
      t.column :manifestation_id, :integer
    end
  end

  def self.down
    drop_table :assoc_manifs
  end
end
