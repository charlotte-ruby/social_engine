class AddArticleIdToPost < ActiveRecord::Migration
  def self.up
    add_column :posts, :article_id, :string
  end

  def self.down
    remove_column :posts, :article_id
  end
end
