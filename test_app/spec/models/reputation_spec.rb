require 'spec_helper'

describe SocialEngine::Reputatable do
  it "should show that user is attached to sociable things" do
    post = Post.create(name: "post")
    user = User.create(name:"john")
    user.votes.size.should eq 0
    user.comments.size.should eq 0
    user.ratings.size.should eq 0
    post.votes.create(value:1,user_id:user.id)
    user.votes(true).size.should eq 1
    post.comments.create(comment:"comment by john",user_id:user.id)
    user.comments(true).size.should eq 1
    post.ratings.create(value:3,user_id:user.id)
    user.ratings(true).size.should eq 1
  end
end
  
describe Reputation do
  it "should update the user rep" do
    SocialEngineYetting.reputation["update_user_model"] = true
    ActiveRecord::Migration.add_column(:users,:reputation,:integer) rescue nil
    user = User.create(:name=>"john",:reputation=>5)
    Reputation.update_user_rep(user,12)
    user.reputation.should eq 17
  end
  
  it "should not add the reputation if no action exists" do
    user = User.create(:name=>"john")    
    Reputation.add("some rep", user)
    Reputation.count.should eq 0
  end
  
  it "should not add the reputation if no user specified" do
    ReputationAction.create(:name=>"some rep", :value=>1)
    Reputation.add("some rep")
    Reputation.count.should eq 0
    Reputation.add("some rep", nil)
    Reputation.count.should eq 0
  end
  
  it "should not add the reputation if no action exists" do
    user = User.create(:name=>"john", :reputation=>3)
    ReputationAction.create(:name=>"some rep", :value=>2)
    Reputation.add("some rep", user)
    Reputation.count.should eq 1
    Reputation.first.user_id.should eq user.id
    Reputation.first.reputation_action_id.should eq ReputationAction.first.id
    Reputation.first.value.should eq 2
  end
  
  it "should not update user model's rep if config set to false" do
    SocialEngineYetting.reputation["update_user_model"] = false
    user = User.create(:name=>"john", :reputation=>3)
    ReputationAction.create(:name=>"some rep", :value=>2)
    Reputation.add("some rep", user)
    user.reputation.should eq 3
  end
end

describe ReputationAction do
  it "should return a list of all the reputation actions defined in the code" do
    ReputationAction.list_from_rails_source.sort.should eq ["commented on", "commentor", "favorited", "upvote", "downvote", "rated"].sort
  end
end