class CreateRatingsTable < ActiveRecord::Migration
  def self.up
    create_table :ratings, :force => true do |t|
      t.string :rateable_type
      t.integer :rateable_id
      t.integer :value
      t.integer :user_id
      t.string :ip_address
      t.string :session_hash
      t.string :browser_fingerprint      
      t.timestamps
    end
    
    add_index :ratings, [:rateable_type, :rateable_id, :ip_address, :browser_fingerprint], :name => "ratings_index", :unique => false
  end

  def self.down
    remove_index :ratings, :name=> :ratings_index
    drop_table :ratings
  end
end