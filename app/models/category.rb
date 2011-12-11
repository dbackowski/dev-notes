class Category < ActiveRecord::Base
  validates :name, :presence => true

  has_many :notes

  def removable?
    notes.blank?
  end
end
