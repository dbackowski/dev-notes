class CategoriesController < ApplicationController
  def index
    @categories = Category.order(:name)
  end

  def show
    @notes = Note.where('category_id = ?', params[:id]).paginate(:page => params[:page])
  end
end
