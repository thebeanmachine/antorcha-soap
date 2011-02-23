class AddMessageTitleInOperations < ActiveRecord::Migration
  def self.up
    add_column :operations, :message_title, :string
  end

  def self.down
    remove_column :operations, :message_title
  end
end