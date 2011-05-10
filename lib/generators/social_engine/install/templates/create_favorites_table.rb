class CreateFavoritesTable < ActiveRecord::Migration
  def self.up
    create_table :favorites, :force => true do |t|
      t.string :favoriteable_type
      t.integer :favoriteable_id
      t.integer :user_id
      t.string :ip_address
      t.string :session_hash
      t.string :browser_fingerprint
      t.timestamps
    end
    add_index :favorites, [:favoriteable_type, :favoriteable_id, :ip_address, :browser_fingerprint], :name => "favorites_index", :unique => false
  end

  def self.down
    remove_index :favorites, :name=> :favorites_index
    drop_table :favorites
  end
end