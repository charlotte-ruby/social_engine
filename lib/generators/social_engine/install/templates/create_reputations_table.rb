class CreateReputationsTable < ActiveRecord::Migration
  def self.up
    create_table :reputations, :force => true do |t|
      t.integer :user_id
      t.integer :reputation_action_id
      t.integer :value
      t.timestamps
    end
    
    add_index :reputations, [:user_id,:reputation_action_id], :name => "user_reputation", :unique => false
    add_index :reputations, :reputation_action_id
  end

  def self.down
    remove_index :reputations, :reputation_action_id
    remove_index :reputations, :name=> :user_reputation
    drop_table :reputations
  end
end