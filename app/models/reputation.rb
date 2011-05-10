class Reputation < ActiveRecord::Base
  belongs_to :user
  belongs_to :reputation_action
  
  def self.add(name,*users)
    reputation_action = ReputationAction.where(:name=>name).first
    if reputation_action.present? and users
      users.each do |user|
        if user.present?
          self.create(:user_id=>user.id,:reputation_action_id=>reputation_action.id,:value=>reputation_action.value)
          self.update_user_rep(user,reputation_action.value)
        end
      end
    end
  end
  
  def self.update_user_rep(user,value)
    if SocialEngineYetting.reputation["update_user_model"]
      rep_field = SocialEngineYetting.reputation["user_model_rep_field_name"].to_s.to_sym
      new_rep_value = user.send(rep_field).to_i + value
      user.update_attributes(rep_field=>new_rep_value)
    end
  end
end