class Friending < ActiveRecord::Base
  belongs_to :friendee, :class_name=>'User'
  belongs_to :friendor, :class_name=>'User'
  validates_uniqueness_of :friendee_id, :scope=> :friendor_id
end
