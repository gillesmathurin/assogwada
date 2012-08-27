# -*- encoding : utf-8 -*-
class AjoutColNomConvAConvPluris < ActiveRecord::Migration
  def self.up
    add_column :conv_pluris, :nom_conv, :string
  end

  def self.down
    remove_column :conv_pluris, :nom_conv
  end
end
