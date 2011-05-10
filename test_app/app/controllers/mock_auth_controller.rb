# Mocking login/ logout
class MockAuthController < ApplicationController
  
  def login
    session[:user_id] = 1
    redirect_to :back
  end
  
  def logout
    session[:user_id] = nil
    redirect_to :back
  end
end