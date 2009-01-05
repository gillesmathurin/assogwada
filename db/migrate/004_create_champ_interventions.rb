class CreateChampInterventions < ActiveRecord::Migration
  def self.up
    create_table :champ_interventions do |t|
      t.column :nom, :string
    end
  end

  def self.down
    drop_table :champ_interventions
  end
end
