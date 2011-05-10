module SocialEngineHelper
  def tweetme(options={})
    defaults = {count: SocialEngineYetting.tweetme["count"], url: request.url, div_class: SocialEngineYetting.tweetme["div_class"]}
    options.reverse_merge!(defaults)
    render "third_party/tweetme", options: options
  end
  
  def fb_like(options={})
    defaults = get_defaults(:fb_like)
    options.reverse_merge!(defaults)
    options.reverse_merge!(:url=>request.url)
    render "third_party/fblike", options: options
  end
  
  def fb_friend_box(options={})
    defaults = get_defaults(:fb_friend_box)            
    options.reverse_merge!(defaults)
    render "third_party/fb_friend_box", options: options
  end
  
  def fb_og_tags(options={})
    defaults = get_defaults(:fb_og_tags)
    options.reverse_merge!(defaults)
    render "third_party/fb_og_tags", options: options
  end
  
  def fb_javascript_sdk(options={})
    defaults = get_defaults(:fb_javascript_sdk)
    options.reverse_merge!(defaults)
    render "third_party/fb_javascript_sdk", options: options
  end
  
  def comment_form(commentable,*options)
    options = options.to_options_hash
    defaults = get_defaults(:comment_form)
    options.optional_reverse_merge!(defaults, [:comment])
    render "comments/form", commentable: commentable, comment: Comment.new, options: options
  end
  
  def comments_list(commentable, options={})
    defaults = get_defaults(:comment_list)
    options.reverse_merge!(defaults)
    comments = commentable.comments.order("id #{options[:order]}")
    comments = comments.limit(options[:display_limit]) if options[:display_limit].is_a? Fixnum
    render "comments/list", commentable: commentable, options: options, comments: comments
  end
  
  def favorites_widget(favoriteable,options={})
    if current_user
      defaults = get_defaults(:favorites_widget)
      options.reverse_merge!(defaults)
      favorite = Favorite.where(favoriteable_type:favoriteable.class.to_s, favoriteable_id: favoriteable.id, user_id: current_user.id).first rescue Favorite.new
      render "favorites/widget", favoriteable: favoriteable, favorite: favorite, options: options
    end
  end

  def vote_widget(voteable,options={})
    defaults = get_defaults(:vote_widget)
    options.reverse_merge!(defaults)
    render "votes/widget", voteable: voteable, options: options
  end

  ##
  def rating_form(rateable,options={})
    defaults = get_defaults(:rating_form)
    options.reverse_merge!(defaults)
    render "ratings/form",  rateable: rateable, rating: Rating.new, options: options
  end
    
  def get_defaults(key)
    begin
      SocialEngineYetting.send(key).symbolize_keys! 
    rescue
      puts "WARNING: Defaults not found for #{key} in SocialEngineYettings.  This key is missing from config/yettings/social_engine.yml"
      return {}
    end
  end
  
  def div_id(klass)
    "se-#{klass.class.to_s.underscore.gsub('_','-')}#{klass.id}"
  end
end