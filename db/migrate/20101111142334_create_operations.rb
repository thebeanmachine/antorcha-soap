class CreateOperations < ActiveRecord::Migration
  def self.up
    create_table :operations do |t|
      t.integer :message_id, :null => false

      t.timestamps
    end
    
    add_index :operations, :message_id, :unique => true
  end

  def self.down
    remove_index :operations, :column => :message_id
    drop_table :operations
  end
end
