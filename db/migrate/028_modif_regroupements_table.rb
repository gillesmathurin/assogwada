class ModifRegroupementsTable < ActiveRecord::Migration
  def self.up
    rename_column :regroupements, :fedeRgptDispoConv_id, :dispositif_id
  end

  def self.down
    rename_column :regroupements, :dispositif_id, :fedeRgptDispoConv_id
  end
end
