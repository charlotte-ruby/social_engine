class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user, :logged_in?

  def current_user
    @current_user ||= User.find(session[:user_id]) rescue nil
  end

  def logged_in?
    current_user != nil
  end  
end
