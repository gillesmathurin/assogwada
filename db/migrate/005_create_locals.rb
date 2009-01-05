class CreateLocals < ActiveRecord::Migration
  def self.up
    create_table :locals do |t|
      t.column :adresse, :string
      t.column :cp, :integer
      t.column :ville, :string
      t.column :jour_recep_debut, :string
      t.column :jour_recep_fin, :string
      t.column :h_recep_debut, :time
      t.column :h_recep_fin, :time
      t.column :association_id, :integer
    end
  end

  def self.down
    drop_table :locals
  end
end
