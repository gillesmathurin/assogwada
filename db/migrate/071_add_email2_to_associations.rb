class AddEmail2ToAssociations < ActiveRecord::Migration
  def self.up
    add_column :associations, :email2, :string
  end

  def self.down
    remove_column :associations, :email2
  end
end
