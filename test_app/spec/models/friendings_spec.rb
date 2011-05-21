require 'spec_helper'

describe Friending do
  fixtures :users, :friendings

  it "should find john's friends" do
    john = users(:john)
    friends = john.friends
    friends.should include(users(:johns_friend)) 
    friends.should include(users(:everyones_friend)) 
    friends.should_not include(users(:rejected_friend)) 
    friends.should_not include(users(:pending_friendor)) 
  end

  it "should find jay's friends" do
    jay = users(:jay)
    friends = jay.friends
    friends.should include(users(:jays_friend)) 
    friends.should include(users(:everyones_friend)) 
    friends.should_not include(users(:rejected_friend)) 
    friends.should_not include(users(:pending_friendor)) 
  end

  it "should find jay's friendors" do
    jay = users(:jay)
    jay.should have(1).friendors
    jay.friendors.should include(users(:everyones_friend)) 
    jay.friendors.should_not include(users(:rejected_friend)) 
    jay.friendors.should_not include(users(:pending_friendor)) 
  end

  it "should find jay's friendees" do
    jay = users(:jay)
    jay.should have(1).friendee
    jay.friendees.should include(users(:jays_friend)) 
  end
end
