class AddForeignKeyAtCategoryIdOnNotes < ActiveRecord::Migration
  def up
    add_foreign_key :notes, :categories, :column => 'category_id'
  end

  def down
    remove_foreign_key :notes, :column => 'category_id'
  end
end
