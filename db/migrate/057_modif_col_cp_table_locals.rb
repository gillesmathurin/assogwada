class ModifColCpTableLocals < ActiveRecord::Migration
  def self.up
    remove_column :locals, :cp
    add_column :locals, :cp, :string
  end

  def self.down
    remove_column :locals, :cp
    add_column :locals, :cp, :integer
  end
end
