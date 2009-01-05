class AjoutColonneTelephoneALocals < ActiveRecord::Migration
  def self.up
    add_column :locals, :telephone, :string
  end

  def self.down
    remove_column :locals, :telephone
  end
end
