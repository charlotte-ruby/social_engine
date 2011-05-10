class Article < ActiveRecord::Base
  is_commentable
  is_voteable
  is_rateable
  is_favoriteable
  has_many :posts
  belongs_to :user
end
