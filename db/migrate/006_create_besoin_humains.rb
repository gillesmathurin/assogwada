class CreateBesoinHumains < ActiveRecord::Migration
  def self.up
    create_table :besoin_humains do |t|
      t.column :categorie, :string
      t.column :quantite, :integer
      t.column :association_id, :integer
    end
  end

  def self.down
    drop_table :besoin_humains
  end
end
