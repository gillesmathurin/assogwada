# -*- encoding : utf-8 -*-
class CreateSalaries < ActiveRecord::Migration
  def self.up
    create_table :salaries do |t|
      t.column :poste, :string
      t.column :sexe, :string
      t.column :contrat_classique, :boolean
      t.column :contrat_aide, :boolean
      t.column :association_id, :integer
    end
  end

  def self.down
    drop_table :salaries
  end
end
