class Rating < ActiveRecord::Base
  belongs_to :rateable, :polymorphic=>true
  belongs_to :user  
  validates_uniqueness_of :rateable_type, :scope=> SocialEngine::Helpers::Fingerprint.fingerprint_type(:rateable_id),
                          :if => Proc.new { |x| SocialEngineYetting.fingerprint_method != "none" }
end