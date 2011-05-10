class CreateVotesTable < ActiveRecord::Migration
  def self.up
    create_table :votes, :force => true do |t|
      t.string :voteable_type
      t.integer :voteable_id
      t.integer :user_id
      t.integer :value
      t.string :ip_address
      t.string :session_hash
      t.string :browser_fingerprint            
      t.timestamps
    end
    
    add_index :votes, [:voteable_type, :voteable_id, :ip_address, :browser_fingerprint], :name => "votes_index", :unique => false
  end

  def self.down
    remove_index :votes, :name=> :votes_index
    drop_table :votes
  end
end