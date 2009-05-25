class ChangeRecipientsColumnFromStringToText < ActiveRecord::Migration
  def self.up
    change_column(:mailings, :recipients, :text)
  end

  def self.down
    change_column(:mailings, :recipients, :string)
  end
end
