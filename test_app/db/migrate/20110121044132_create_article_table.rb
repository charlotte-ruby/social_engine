class CreateArticleTable < ActiveRecord::Migration
  def self.up
    create_table :articles, :force => true do |t|
      t.string :name
      t.integer :user_id
      t.timestamps
    end
  end

  def self.down
    drop_table :articles
  end
end