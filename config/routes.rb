Rails.application.routes.draw do
  resources :comments, :ratings, :votes, :favorites, :reputation_actions
end