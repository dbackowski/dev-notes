class NotesController < ApplicationController
  before_filter :get_categories, :only => [:new, :create, :edit, :update]
  before_filter :authorize, :only => [:new, :create, :edit, :update, :destroy]
  before_filter :cancel_form, :only => [:create, :update]

  private
  def get_categories
    @categories = Category.order('name')
  end
  
  def cancel_form
    if params['commit'] == 'cancel'
      redirect_to note_path
    end
  end

  public
  def index
    if @logged_user.present?
      @notes = Note.paginate(:page => params[:page])
    else
      @notes = Note.public_visible_only.paginate(:page => params[:page])
    end
  end

  def show
    if @logged_user.present?
      @note = Note.find(params[:id])
    else
      @note = Note.public_visible_only.find(params[:id])
    end
  end

  def new
    @note = Note.new
  end

  def edit
    @note = Note.find(params[:id])
  end

  def create
    @note = Note.new(params[:note])
    @note.add_user_id = @logged_user.id
    
    if @note.save
      redirect_to @note, :notice => 'Note was successfully created.'
    else
      render :action => "new"
    end
  end

  def update
    @note = Note.find(params[:id])

    if @note.update_attributes(params[:note])
      redirect_to @note, :notice => 'Note was successfully updated.'
    else
      render :action => "edit"
    end
  end

  def search
    search = "%#{params[:search]}%"

    if @logged_user.present?
      @notes = Note.where("title like ? OR description like ?", search, search).paginate(:page => params[:page])
    else
      @notes = Note.public_visible_only.where("title like ? OR description like ?", search, search).paginate(:page => params[:page])
    end
    
    render :partial => 'notes'
  end
  
  def destroy
    @note = Note.find(params[:id])
    @note.destroy

    redirect_to notes_url
  end
end
