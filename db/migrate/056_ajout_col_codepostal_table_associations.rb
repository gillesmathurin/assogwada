# -*- encoding : utf-8 -*-
class AjoutColCodepostalTableAssociations < ActiveRecord::Migration
  def self.up
    add_column :associations, :code_postal, :string
  end

  def self.down
    remove_column :associations, :code_postal
  end
end
