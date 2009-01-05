class AjoutLocalIdAPlannings < ActiveRecord::Migration
  def self.up
    add_column :plannings, :local_id, :integer
  end

  def self.down
    remove_column :plannings, :local_id
  end
end
