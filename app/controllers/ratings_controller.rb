class RatingsController < InheritedResources::Base
  def create
    @rating = Rating.new(params[:rating])
    set_polymorphic_vars(@rating,"rateable")
    add_fingerprint_and_user_id(@rating)

    create! do |success, failure|
      success.html do
        Reputation.add("rated",current_user)
        redirect_to :back
      end
      failure.html { redirect_to :back }
    end
  end
end