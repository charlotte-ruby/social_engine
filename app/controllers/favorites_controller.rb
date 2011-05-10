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
    destroy!{:back}
  end
end