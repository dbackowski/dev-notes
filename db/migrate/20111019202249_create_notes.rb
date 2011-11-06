class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.integer :category_id
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
