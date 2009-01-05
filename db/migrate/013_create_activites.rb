class CreateActivites < ActiveRecord::Migration
  def self.up
    create_table :activites do |t|
      t.column :nom, :string
      t.column :tarif_mensuel, :decimal, :precision => 8, :scale =>2
      t.column :modalite_inscription, :text
      t.column :info_supp, :text
      t.column :public, :string
      t.column :jour, :string
      t.column :h_dbt, :time
      t.column :h_fin, :time
      t.column :besoin_habilitation, :boolean, :default => false
      t.column :association_id, :integer
    end
  end

  def self.down
    drop_table :activites
  end
end
