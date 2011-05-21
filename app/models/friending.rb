class Rating < ActiveRecord::Base
  belongs_to :friendee, :polymorphic=>true
  belongs_to :friendor, :polymorphic=>true
  validates_uniqueness_of :friendee_id, :scope=> :friendor_id
end
