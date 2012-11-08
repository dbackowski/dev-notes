class CategoriesController < ApplicationController
  def index
    @categories = Category.order(:name)
  end

  def show
    @category = Category.find(params[:id])
    
    if @logged_user.present?
      @notes = Note.where('category_id = ?', params[:id]).paginate(:page => params[:page])
    else
      @notes = Note.public_visible_only.where('category_id = ?', params[:id]).paginate(:page => params[:page])
    end
  end
end
