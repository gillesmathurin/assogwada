class AjoutColPermalinkTableAssociations < ActiveRecord::Migration
  def self.up
    add_column :associations, :permalink, :string
  end

  def self.down
    remove_column :associations, :permalink
  end
end
