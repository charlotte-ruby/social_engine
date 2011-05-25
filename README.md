# social_engine

social_engine is a rails engine that provides very basic social functionality that you can attach to any model, including comments, ratings, voting, favorites, user reputation, and friend relations.  This plugin is intended to provide you with building blocks, as opposed to a full blown social networking site.  Each building block is customizable and social_engine provides the controllers, helpers, models and css friendly views.  You just include the helpers in your view, provide any non-default options and customize the look using CSS.  This is only compatible with Rails 3 and Ruby 1.9.2.

## Installation

Add this to your Gemfile and run "bundle install"
  
    gem "social_engine"

Run the social_engine generator to add the needed migrations and static assets
  
    rails g social_engine:install
    
If you plan on using the user reputation module, then you will also need to run that generator, which will alter your 'users' table and add a field named "reputation"

    rails g social_engine:user_reputation

Run the migrations

    rake db:migrate

This will add the following tables to your database:

    comments
    ratings
    votes
    favorites
    reputations
    reputation_actions
    friendings

## Usage

Here is an example of how you would add functionality this on an 'Article' model:

    class Article < ActiveRecord::Base
      is_sociable
    end
    
When you add this line to your model, it makes it rateable, voteable and commentable, and favoriteable.  You can also add the functionality individually if you do not want all 4 social aspects in your model.

    class Article < ActiveRecord::Base
      is_commentable
      is_voteable
      is_rateable
      is_favoriteable
    end
    
You will also need to add nested resources to the Article route.  In config/routes.rb:

    resources :articles do
      resources :comments,:votes,:ratings,:favorites
    end

Make your user model social and make it have reputation

    class User < ActiveRecord::Base
      has_reputation
      is_social
    end

If you want users to also be able to 'friend' each other, just add this

    class User < ActiveRecord::Base
      has_reputation
      is_social
      is_friendable
    end


## View helpers

For most situations, these helpers will suffice.  The view helpers will give you forms, widgets or lists and social_engine provides controllers that will redirect to :back when you submit the forms.  Using HAML for examples, but you can use the same inside <% %> for erb
    
create up/down/count vote widget (similar to Stack Overflow)

    = vote_widget(@article)

adds 5 radio buttons (by default) and a submit to rate something 1-5

    = rating_form(@article)
    
add a rating form with custom number of radio buttons

    = rating_form(@article, 3)

Create a default comment form

    = comment_form(@article)
    
Create a comment form using options.  By default, the form will ask for name, email and website.  You can specify which fields you want and the text that should be displayed as the label for each.

    # pass symbols to use the default name and email labels
    = comment_form(@article, :name , :email)
    # customize the name label by passing a value
    = comment_form(@article, :name=>{:label=>"My Name"} , :email)

List the comments using defaults

    = comments_list(@article)
    
List the comments with options.  Defaults shown, all options are optional.  For the date format, you should use the formats show here: http://snippets.dzone.com/posts/show/2255

    = comments_list(@article, {:display_posted_by => true, 
                               :display_date => true, 
                               :date_format => "%m/%d/%Y at %H:%M"})

Button so user can add it to their favorites list.  This button will toggle b/w Add & Remove

    = favorites_widget(@article)

Default Tweetme button

    = tweetme

Tweetme button with options (all are optional with defaults shown as the values in this example)

    = tweetme(:url => "http://mysaweetsite.com", 
              :text => "This website is saweet!", 
              :via => "@cowboycoded", # appends via to end of tweet
              :count => "horizontal")  # this will show the tweet count:  horizontal, vertical or none

Default Facebook Like button

    = fb_like

Facebook Like button with options (all are optional with defaults shown as the values in this example)

    = fb_like(:url => request.url, 
              :layout => "standard", # standard, button_count or box_count
              :faces => true, # true or false
              :width => 450, # your choice
              :action => "like", # like or recommend
              :font => "lucida grande", # arial, lucida grande, segoi ui, tahoma, trebuchet ms, or verdana
              :colorscheme => "light",  #light or dark
              :div_id: "fblike")  #your choice
        
Default Facebook Friend box

    = fb_friend_box
    
Facebook Friend box with options (all are optional)

    = fb_friend_box( :width => 250, 
                     :stream => false, 
                     :header => true, 
                     :faces => true, 
                     :fb_page_url => "http://www.facebook.com/couponshack" )
                     
                     
                     
The views are meant to be CSS friendly and allow you to adjust the look of every part of the view by overriding the default styles.  You can make changes to public/stylesheets/social_engine.css.
    
## Models

You are not tied to using the provided views and controllers to manage comments, votes, favorites and reputation.  If you prefer your own implementation of controllers & views, you can still use the functionality of the models.

Again, you need to make your model sociable first and make your user model have rep and be social

    class Post < ActiveRecord::Base
      is_sociable
    end
    
    class User < ActiveRecord::Base
      is_social
      has_reputation
    end

Once your model is sociable, you can add comments, ratings, votes, and favorites in the following ways.  

First create an instance of Post, so we can use the social methods that are included when you specify the post is_sociable:

    post = Post.create(:name => "post")

###Voting:

Upvote a post:

    post.upvote
    post.vote_count #=> 1
    
Downvote a post:

    post.downvote
    post.vote_count #=> -1

Create a vote and vote value manually:
 
    post.votes.create(:value => 99)
    post.vote_sum #=> 99

Delete all votes for a post:

    post.upvote
    post.votes.first.destroy
    post.votes.size #=> 1  Why?? The set is cached
    post.votes(true) # you have to reload the set by passing true
    post.votes.size #=> 0
    
NOTE: By default, voting is restricted to one per ip_address per object.  There are 2 ways around this:
1. Set fingerprint_method to "none" in config/yettings/social_engine.yml, which will disable the uniqueness validation
2. pass validate false to the save method to skip validations.  You have to use new/save instead of create like so:
    
    vote = post.votes.new(:value=>1)
    vote.save(false) # or vote.save(:validate=>false)

###Comments

Create a comment and attach a user to it

    post.comments.create(:comment => "I'm sure whatever your thinking is correct", :user_id=>123)
    
Create a comment using an anauthenticated user

    post.comments.create(:comment => "I'm sure whatever your thinking is correct", 
                         :unauthenticated_name => "ignored name",
                         :unauthenticated_email => "ignore@email.com",
                         :unauthenticated_website => "http://ignore.com")

Destroy a comment

    post.comments.first.destroy
    post.comments(true)  # remove the cache, so you can get the correct array size if you need it

###Ratings    

Create a new rating with a user_id

    post.ratings.create(:value=>5, :user_id=>123)
    
Destroy a rating for a user_id

    post.ratings.where(:user_id=>123).destroy_all
    
Destroy all ratings for a post

    post.ratings.destroy_all

###Favorites

    post.favorites.create(:user_id=>123)
    User.find(123).favorites #=> outputs the favorite you just created

###Reputation

A primitive admin panel is provided to allow you to adjust reputation action values based on their name.  The names of all reputation actions are pulled directly from 
the source code and a list is provided at the bottom of the admin panel for your convenience.

There is a Reputation model and a ReputationAction model.  Reputation stores the reputation_action_id, user_id, and the value.  ReputationAction stores the name of an action, which is defined by you, and the default value.  
Note that if you change the value, you will have to update the existing records in the reputation table manually.  By default, the reputation table stores the value of the reputation action at the time of creation.
So in order for you to add reputation points to a user, you have to define the action and pass the user.  Let's say you have a reputation action called "answered question" with a value of 5 points.  And you have a controller 
called answers, with a create method.  You would add this method to the controller:

    class AnswersController < ApplicationController
      def create
        #do some stuff here to create the answer
        
        # add the reputation
        Reputation.add("answered question", current_user)
      end

The method aboves assumes that "current_user" returns the logged in user in this session.  This add a record to the reputations table.  If you ran the user_reputation generator shown in the Installation section of this document, then 
then Reputation.add will also add the value of that reputation action to the "reputation" field in the users table.  This field is used to avoid joins and store the sum of all reputation record's values for that user.

Assuming you have the "reputation" field in your users table, you just do this to get the total reputation value:

    User.first.reputation
    
Or if you choose not to add that field, you can get the reputation this way:

    User.first.reputations.sum(:value)

### Friends
By making your User model friendable, you allow users to request friends and to confirm or reject friendship requests that come their way. The friendship model is directional, meaning it distinguishes between the friendor and the friendee. This may be useful for situations where users can "follow" others, while having many followers.

You can have @user request to be friends with @other_user

    @user.add_friend(@other_user)

Get the last user who requested to be friends with @other_user

    @other_user.requesting_friends.last #=> @user

You can get the same result through the Friending record for that request

    @other_user.friend_requests.last.friendor #=> @user

Confirm the request

    @other_user.friend_requests.last.confirm

Or reject it

    @other_user.friend_requests.last.reject

If you want your app to skip the confirmation step and automatically activate all friend requests, set confirm_friends to "false" in config/yettings/social_engine.yml

You also get the following instance methods for your users

    @user.friends   #=> Return collection of users that are friends with @user
    @user.friendors #=> Only list friends that have requested friendship with @user
    @user.friendees #=> Only list friends that @user has requested friendship with

These methods return only friends that are confirmed and not rejected. To get info on unconfirmed friends:

    @user.pending_friends    #=> Return users that have not confirmed friendship requests from @user.
                             #   This will include users that have rejected a friendship request from @user.
    @user.requesting_friends #=> Return users that have requested to be friends with @user, but which @user has not confirmed
    @user.rejected_friends   #=> users from which @user has rejected a friendship request

The above methods are all associated with collections of Friending instances, which can be obtainer from the friendorings, friendeeings, pending_friendships, friend_requests, and friend_rejections instance methods for User.

## Development Roadmap / TODO
###Features
1. More helpers for reputation
2. Ajax methods for controllers & views, so you don't have to redirect_to :back
3. Improve CSS and views

###Behind the scenes
1. Better test coverage
2. Refactoring and DRYing (mainly tests)



## Contributing to social_engine
 
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it
* Fork the project
* Start a feature/bugfix branch
* Commit and push until you are happy with your contribution
* Make sure to add tests.  Patches will not be accepted without Rspec or Cucumber tests.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

## Copyright

Copyright (c) 2011 John McAliley. See LICENSE.txt for
further details.

