class UsersController < ApplicationController
  before_filter :get_user, :only => [:edit, :update, :show, :passwd, :destroy]
  before_filter :cancel_form, :only => [:passwd, :update] 
  before_filter :authorize, :except => :show
  
  private
  def cancel_form
    if params['commit'] == 'cancel'
      redirect_to user_path(@user)
    end
  end

  private 
  def get_user
    if @logged_user.admin
      @user = User.find(params[:id])
    else
      @user = User.find(@logged_user.id)
    end
  end

  public
  def update
    @user = User.find(params[:id])

    if @user.update_attributes(params[:user])
      redirect_to user_path(@user), :notice => 'User was successfully updated.'
    else
      render :action => 'edit'
    end
  end

  def passwd
    if request.put?
      if @user.change_passwd(params[:user])
        redirect_to user_path(@user), :notice => 'User password was successfully changed.'
      else
        render :action => 'passwd'
      end
    end
  end

  def destroy
    @user.destroy

    redirect_to admin_users_path
  end
end
