class AjoutColRecipientsAMailings < ActiveRecord::Migration
  def self.up
    add_column :mailings, :recipients, :string
  end

  def self.down
    remove_column :mailings, :recipients
  end
end
