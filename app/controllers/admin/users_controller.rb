class Admin::UsersController < ApplicationController
  before_filter :cancel_form, :only => [:create, :update] 
  before_filter :authorize
  before_filter :admin_permission
  
  private
  def cancel_form
    if params['commit'] == 'cancel'
      redirect_to admin_users_path
    end
  end

  public
  def index
    @users = User.order(:login)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])

    if @user.save
      redirect_to admin_users_path, :notice => 'User was successfully created.'
    else
      flash.now[:error] = 'Unable to save user.'
      render :action => "new"
    end
  end
end
