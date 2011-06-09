class FavoritesController < InheritedResources::Base
  def create
    create! do |success, failure|
      success.html do
        add_fingerprint_and_user_id(@favorite,true)
        add_able_rep("favorited",@favorite)
        redirect_to :back
      end
      failure.html { redirect_to :back }
    end
  end
  
  def destroy
    def destroy
      destroy! do |success, failure|
        success.html{redirect_to :back}
        failure.html{redirect_to :back}
      end
    end
  end
end