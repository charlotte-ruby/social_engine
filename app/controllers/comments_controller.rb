class CommentsController < InheritedResources::Base
  def create
    create! do |success, failure|
      success.html do
        add_fingerprint_and_user_id(@comment,true)
        add_able_rep("commented on",@comment)
        Reputation.add("commentor",current_user)
        redirect_to :back
      end
      failure.html { redirect_to :back }
    end
  end
end