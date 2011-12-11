class SessionsController < ApplicationController
  skip_filter :authorize
  
  def create
    user = User.where("login = ? AND passwd = ?", params[:user][:login], params[:user][:passwd]).first
    
    unless user.blank?
      session[:user_id] = user.id

      unless session[:redirect_to].blank?
        redirect_to session[:redirect_to]
      else
        redirect_to notes_path
      end
    else
      flash[:error] = 'Log in failed'
      render :action => :new      
    end
  end
  
  def destroy
    reset_session
    redirect_to notes_path
  end
end
