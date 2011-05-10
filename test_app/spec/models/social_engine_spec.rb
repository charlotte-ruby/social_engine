require 'spec_helper'

describe SocialEngine do
  it "should include its methods in AR" do
    ActiveRecord::Base.methods.include?(:is_commentable).should be true
    ActiveRecord::Base.methods.include?(:is_rateable).should be true
    ActiveRecord::Base.methods.include?(:is_favoriteable).should be true    
    ActiveRecord::Base.methods.include?(:is_voteable).should be true
    ActiveRecord::Base.methods.include?(:has_reputation).should be true
  end
      
  it "should be sociable" do
    post = Post.create(name: "post")
    post.favoriteable?.should be true
    post.commentable?.should be true
    post.rateable?.should be true
    post.voteable?.should be true            
  end
end
