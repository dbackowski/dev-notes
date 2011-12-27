class AddPublicVisibleToNotes < ActiveRecord::Migration
  def change
    add_column :notes, :public_visible, :boolean, :default => 1
  end
end
