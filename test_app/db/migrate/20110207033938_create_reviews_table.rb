class CreateReviewsTable < ActiveRecord::Migration
  def self.up
    create_table :reviews, :force => true do |t|
      t.string :reviewable_type
      t.integer :reviewable_id
      t.integer :user_id
      t.string :unauthenticated_name
      t.string :unauthenticated_email
      t.string :unauthenticated_website
      t.text :review
      t.string :pros
      t.string :cons
      t.string :ip_address      
      t.timestamps
    end
  end

  def self.down
    drop_table :reviews
  end
end