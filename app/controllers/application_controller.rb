class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :get_logged_user

  def authorize
    unless session[:user_id]
      session[:redirect_to] = request.fullpath
      redirect_to new_sessions_path
    end
  end    

  def get_logged_user
    unless session[:user_id].blank?
      @logged_user = User.find(session[:user_id])
    end
  end
end
