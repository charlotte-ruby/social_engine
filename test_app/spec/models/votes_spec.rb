require 'spec_helper'

describe Vote do
  it "should be able to vote an article" do
    article =Article.create(name: "test")
    article.votes.create(:value=>1)
    article.votes.size.should eq 1
  end
  
  it "should show the total vote count of an article as 1 after one upvote" do
    article =Article.create(name: "test")
    article.upvote
    article.vote_sum.should eq 1
  end
  
  it "should show the total vote count of an article as -1 after one downvote" do
    article =Article.create(name: "test")
    article.downvote
    article.vote_sum.should eq -1
  end

  it "should show the total vote count after a variety of up/down votes" do
    article =Article.create(name: "test")
    article.downvote
    article.upvote
    article.vote_sum.should eq 0
    article.upvote
    article.upvote
    article.vote_sum.should eq 2
    article.downvote
    article.vote_sum.should eq 1
    article.downvote
    article.downvote
    article.vote_sum.should eq -1
    article.downvote
    article.vote_sum.should eq -2
  end
  
  it "should be able to upvote a comment" do
    article =Article.create(name: "test")
    article.comments.create(comment: "good stuff")
    article.comments.first.upvote
    article.comments.first.vote_sum.should eq 1
  end
  
  it "should be able to delete a vote" do
    article =Article.create(name: "test")
    article.upvote
    Vote.all.size.should eq 1
    article.votes.first.destroy
    article.votes(true).size.should eq 0
    Vote.all.size.should eq 0
  end
end
