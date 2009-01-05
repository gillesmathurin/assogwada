class CreateBesoinMateriels < ActiveRecord::Migration
  def self.up
    create_table :besoin_materiels do |t|
      t.column :categorie, :string
      t.column :desc, :text
      t.column :quantite, :integer
      t.column :association_id, :integer
    end
  end

  def self.down
    drop_table :besoin_materiels
  end
end
