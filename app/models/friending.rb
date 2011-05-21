class Friending < ActiveRecord::Base
  belongs_to :friendee, :class_name=>'User'
  belongs_to :friendor, :class_name=>'User'
  validates_uniqueness_of :friendee_id, :scope=> :friendor_id
  validate :not_friending_self

  def confirm
    self.update_attributes(:confirmed=>true)
  end

  def reject
    self.update_attributes(:rejected=>true)
  end

private
  def not_friending_self
    errors.add(:friendee_id, "can't be the same as friendor_id") if
      friendee_id == friendor_id
  end

end
