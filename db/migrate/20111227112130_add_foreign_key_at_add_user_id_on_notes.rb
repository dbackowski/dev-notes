class AddForeignKeyAtAddUserIdOnNotes < ActiveRecord::Migration
  def up
    add_foreign_key :notes, :users, :column => 'add_user_id'
  end

  def down
    remove_foreign_key :notes, :column => 'add_user_id'
  end
end
