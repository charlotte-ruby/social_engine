require 'spec_helper'

describe Rating do
  fixtures :articles
  before(:each) do
    @article = Article.find(99)
  end

  it "should be able to rate an article with a rating" do
    @article.ratings.create(value:5)
    @article.ratings.size.should eq 1
    @article.ratings.first.value.should eq 5
  end
  
  it "should return formatted avg rating using default dec places" do
    @article.ratings.create(value:5)
    @article.avg_rating_formatted.should eq "5.0"
  end
  
  it "should return avg rating using specified dec places" do
    @article.ratings.create(value:5)
    @article.avg_rating.should eq 5
    @article.avg_rating_formatted(0).should eq "5"
    @article.avg_rating_formatted(1).should eq "5.0"    
  end
  
  it "should return avg rating of 0 if no ratings" do
    @article.avg_rating.should eq 0
    @article.avg_rating_formatted.should eq "0.0"
  end
  
  it "should return rating count" do
    @article.rating_count.should eq 0
    @article.ratings.create(value:5)
    @article.rating_count.should eq 1
    @article.ratings.create(value:4)
    @article.rating_count.should eq 2
  end
end