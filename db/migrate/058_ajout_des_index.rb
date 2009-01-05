class AjoutDesIndex < ActiveRecord::Migration
  def self.up
    add_index :associations, [:nom, :sigle, :ville], :name => "assos_idx"
    add_index :associations_champ_interventions, [:association_id, :champ_intervention_id], :name => "assos_ci_join_idx"
    add_index :assoc_manifs, [:association_id, :manifestation_id], :name => "asso_manif_idx"
    add_index :champ_interventions, :nom
  end

  def self.down
    remove_index :champ_interventions, :nom
    remove_index :assoc_manifs, :name => :asso_manif_idx
    remove_index :associations_champ_interventions, :name => :index_name
    remove_index :associations, :name => :index_name
  end
end
