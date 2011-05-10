require 'spec_helper'

describe Comment do
  fixtures :articles
  before(:each) do
    @article = Article.find(99)
  end

  it "should be able to save a comment for an article" do
    @article.comments.create(:comment=>"this is a test comment")
    @article.comments.size.should eq 1
    @article.comments[0].comment.should eq "this is a test comment"
    Comment.all.size.should eq 1
  end

  it "should be delete comment if article is deleted" do
    @article.comments.create(:comment=>"this is a test comment")
    @article.destroy
    @article.comments(true).size.should eq 0
    Comment.all.size.should eq 0
  end

  it "should show no comments for an article if its comments are destroyed" do
    @article.comments << Comment.create(:comment=>"this is a test comment")
    Comment.first.destroy
    @article.comments(true).size.should eq 0
  end

  it "should return unauthenticated name,email,website for a comment when user done" do
    comment = Comment.create(unauthenticated_name:"john",unauthenticated_email:"john@couponshack.com",unauthenticated_website:"http://www.couponshack.com")
    comment.name.should eq "john"
    comment.email.should eq "john@couponshack.com"
    comment.website.should eq "http://www.couponshack.com"
  end

  it "should return user name,email,website when authenticated user attached to comment" do
    user = mock_model(User, :id => 1,:name => "Mock Name", :email=>"mock@email.com", :website=>"http://mockwebsite.com")
    comment = Comment.create(comment:"test",user: user,unauthenticated_name:"ignored name",unauthenticated_email:"ignore@email.com",unauthenticated_website:"http://ignore.com")
    comment.name.should eq "Mock Name"
    comment.email.should eq "mock@email.com"
    comment.website.should eq "http://mockwebsite.com"
  end
end