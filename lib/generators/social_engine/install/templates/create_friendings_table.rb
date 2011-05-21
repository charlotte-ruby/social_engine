class CreateFriendingsTable < ActiveRecord::Migration
  def self.up
    create_table :friendings, :force => true do |t|
      t.integer :friendor_id
      t.integer :friendee_id
      t.boolean :confirmed, :default => false
      t.timestamps
    end
    
    add_index :friendings, :friendor_id
    add_index :friendings, :friendee_id
  end

  def self.down
    remove_index :friendings, :friendor_id
    remove_index :friendings, :friendee_id
    drop_table :friendings
  end
end
