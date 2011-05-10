class CreateCommentsTable < ActiveRecord::Migration
  def self.up
    create_table :comments, :force => true do |t|
      t.string :commentable_type
      t.integer :commentable_id
      t.integer :user_id
      t.text :comment
      t.string :unauthenticated_name
      t.string :unauthenticated_email
      t.string :unauthenticated_website
      t.string :ip_address
      t.string :session_hash
      t.string :browser_fingerprint      
      t.timestamps
    end    
    add_index :comments, [:commentable_type, :commentable_id, :ip_address, :browser_fingerprint], :name => "comments_index", :unique => false
  end

  def self.down
    remove_index :comments, :name=> :comments_index
    drop_table :comments
  end
end