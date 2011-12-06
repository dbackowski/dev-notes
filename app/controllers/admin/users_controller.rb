class Admin::UsersController < ApplicationController
  before_filter :get_user, :only => [:edit, :update, :show, :destroy]

  private 
  def get_user
    @user = User.find(params[:id])
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
      redirect_to admin_users_path, notice: 'User was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    @user = User.find(params[:id])

    if @user.update_attributes(params[:user])
      redirect_to admin_users_path, notice: 'User was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @user.destroy

    redirect_to admin_users_path
  end
end