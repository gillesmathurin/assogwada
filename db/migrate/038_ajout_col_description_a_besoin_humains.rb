# -*- encoding : utf-8 -*-
class AjoutColDescriptionABesoinHumains < ActiveRecord::Migration
  def self.up
    add_column :besoin_humains, :description, :text
  end

  def self.down
    remove_column :besoin_humains, :description
  end
end
