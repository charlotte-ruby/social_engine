class ReputationActionsController < InheritedResources::Base
  def create
    create!{reputation_actions_url}
  end
  
  def update
    update!{reputation_actions_url}
  end
  
  def destroy
    destroy!{reputation_actions_url}
  end
end