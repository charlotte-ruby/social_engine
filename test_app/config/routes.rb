TestApp::Application.routes.draw do
  resources :articles do
    collection do
      get :comments_list
    end
    resources :comments,:votes,:ratings,:favorites
  end
  match "/third_party/tweetme", to: "third_party#tweetme"
  match "/third_party/fb_like", to: "third_party#fb_like"
  match "/third_party/fb_friend_box", to: "third_party#fb_friend_box"
  match "/articles/:id/comments_test", to: "articles#comments_test"
  match "login", :to=>"mock_auth#login", :as=>"login"
end
