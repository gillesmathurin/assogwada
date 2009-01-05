class RenamePublicColunmInActivites < ActiveRecord::Migration
  def self.up
    rename_column :activites, :public, :spectateur
  end

  def self.down
    rename_column :activites, :spectateur, :public
  end
end
