class VotesController < InheritedResources::Base
  def create
    @vote = Vote.new(params[:vote])
    set_polymorphic_vars(@vote)
    add_fingerprint_and_user_id(@vote)
    create! do |success, failure|
      success.html do
        add_able_rep("upvote",@vote) if @vote.up?
        add_able_rep("downvote",@vote) if @vote.down?
        redirect_to :back
      end
      failure.html { redirect_to :back }
    end
  end
end