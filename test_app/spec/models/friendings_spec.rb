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

  it "should find jay's friend requests" do
    jay = users(:jay)
    jay.should have(1).friend_request
    jay.requesting_friends.should include(users(:pending_friendor)) 
  end

  it "should find pending friend" do
    user = users(:pending_friendor)
    user.should have(1).pending_friend
    user.pending_friends.should include(users(:jay)) 
  end

  it "should let jay friend john" do
    jay = users(:jay)
    john = users(:john)
    jay.add_friend(john)
    jay.should have(1).pending_friends
    jay.pending_friends.should include(john)
    john.should have(1).requesting_friends
    john.requesting_friends.should include(jay)
    john.friends.should_not include(jay)
    puts john.friend_requests.inspect
    john.friend_requests.last.confirm
    puts john.friend_requests.inspect
    puts john.friends.inspect
    #john.should have(3).friends
    john.requesting_friends.should_not include(jay)
    john.friends.should include(jay)
  end
end
