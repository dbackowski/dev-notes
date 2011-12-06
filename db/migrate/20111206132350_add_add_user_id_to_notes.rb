class AddAddUserIdToNotes < ActiveRecord::Migration
  def change
    add_column :notes, :add_user_id, :integer
  end
end
