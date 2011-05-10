class ArticlesController < InheritedResources::Base
  def comments_test
    @article = Article.first
  end
end