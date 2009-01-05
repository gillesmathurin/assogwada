class CreateAssociationsChampInterventions < ActiveRecord::Migration
  def self.up
    create_table :associations_champ_interventions do |t|
      t.column :association_id, :integer
      t.column :champ_intervention_id, :integer
    end
  end

  def self.down
    drop_table :associations_champ_interventions
  end
end
