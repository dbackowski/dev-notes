class Note < ActiveRecord::Base
  validates :category_id, :presence => true
  validates :title, :presence => true
  validates :description, :presence => true
    
  self.per_page = 12
  
  belongs_to :category
end
