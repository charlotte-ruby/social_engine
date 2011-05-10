class Comment < ActiveRecord::Base
  belongs_to :commentable, :polymorphic=>true
  belongs_to :user
  validates_presence_of :comment
  is_voteable
  is_commentable
  is_rateable

  include SocialEngine::Helpers::User
end