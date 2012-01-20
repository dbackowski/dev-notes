class NotesController < ApplicationController
  before_filter :get_categories, :only => [:new, :create, :edit, :update]
  before_filter :authorize, :only => [:new, :create, :edit, :update, :destroy]
  before_filter :cancel_form, :only => [:create, :update]
  before_filter :get_note, :only => [:edit, :update]

  private
  def get_categories
    @categories = Category.order('name')
  end
  
  def cancel_form
    if params['commit'] == 'cancel'
      redirect_to note_path
    end
  end

  def get_note 
    if @logged_user.admin
      @note = Note.find(params[:id])
    else
      @note = Note.where("id = ? AND add_user_id = ?", params[:id], @logged_user.id).first

      raise ActiveRecord::RecordNotFound if @note.nil?
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
    @note = Note.find(params[:id])

    unless @note.public_visible || @logged_user.present?
      authorize
    end
  end

  def new
    @note = Note.new
  end

  def create
    @note = Note.new(params[:note])
    @note.add_user_id = @logged_user.id
    
    if @note.save
      redirect_to @note, :notice => 'Note was successfully created.'
    else
      flash.now[:error] = 'Unable to save note.'
      render :action => "new"
    end
  end

  def update
    if @note.update_attributes(params[:note])
      redirect_to @note, :notice => 'Note was successfully updated.'
    else
      render :action => "edit"
    end
  end

  def search
    search = "%#{params[:search]}%"

    if @logged_user.present?
      @notes = Note.where("lower(title) LIKE lower(?) 
                          OR lower(description) LIKE lower(?)", search, search).paginate(:page => params[:page])
    else
      @notes = Note.public_visible_only.where("lower(title) LIKE lower(?) 
                                              OR lower(description) LIKE lower(?)", search, search).paginate(:page => params[:page])
    end
    
    render :partial => 'notes'
  end

  def preview
    render :partial => 'preview'
  end
  
  def destroy
    @note = Note.find(params[:id])
    @note.destroy

    redirect_to notes_url
  end
end
