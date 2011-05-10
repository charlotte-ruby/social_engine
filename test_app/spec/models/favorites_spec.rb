require 'spec_helper'

describe Favorite do  
  it "should be able to favorite and unfavorite an article" do
    user = mock_model(User, :id => 1,:name => "Mock Name", :email=>"mock@email.com", :website=>"http://mockwebsite.com")
    article = Article.create(name:"test")
    article.favorites.create(user_id:user.id)
    article.favorites.size.should eq 1
  end
end
