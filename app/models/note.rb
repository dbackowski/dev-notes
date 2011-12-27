class Note < ActiveRecord::Base
  validates :category_id, :presence => true
  validates :title, :presence => true
  validates :description, :presence => true
    
  self.per_page = 12
  
  belongs_to :category
  belongs_to :user,
    :foreign_key => 'add_user_id'

  scope :public_visible_only, :conditions => { :public_visible => true }
end
