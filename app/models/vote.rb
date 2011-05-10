class Vote < ActiveRecord::Base
  belongs_to :voteable, :polymorphic=>true
  validates_uniqueness_of :voteable_type, :scope=> SocialEngine::Helpers::Fingerprint.fingerprint_type(:voteable_id), 
                          :if => Proc.new { |x| SocialEngineYetting.fingerprint_method != "none" }
  
  def up?
    self.value>0
  end
  
  def down?
    self.value<0
  end
end