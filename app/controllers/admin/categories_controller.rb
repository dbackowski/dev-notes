class Admin::CategoriesController < ApplicationController
  before_filter :get_category, :only => [:edit, :update, :destroy]
  
  private
  def get_category
    @category = Category.find(params[:id])
  end

  public
  def index
    @categories = Category.order(:name)
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(params[:category])

    if @category.save
      redirect_to admin_categories_path, notice: 'Category was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    if @category.update_attributes(params[:category])
      redirect_to admin_categories_path, notice: 'Category was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @category.destroy

    redirect_to admin_categories_path
  end
end
