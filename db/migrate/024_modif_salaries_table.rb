class ModifSalariesTable < ActiveRecord::Migration
  def self.up
    remove_column :salaries, :contrat_classique
    remove_column :salaries, :contrat_aide
    add_column :salaries, :contrat_classique, :string
    add_column :salaries, :contrat_aide, :string
  end

  def self.down
    remove_column :salaries, :contrat_classique
    remove_column :salaries, :contrat_aide
    add_column :salaries, :contrat_classique, :boolean
    add_column :salaries, :contrat_aide,      :boolean
  end
end
