# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20111227132749) do

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "notes", :force => true do |t|
    t.integer  "category_id"
    t.string   "title"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "add_user_id"
    t.boolean  "public_visible", :default => true
  end

  add_index "notes", ["add_user_id"], :name => "notes_add_user_id_fk"
  add_index "notes", ["category_id"], :name => "notes_category_id_fk"

  create_table "users", :force => true do |t|
    t.string   "login"
    t.string   "passwd"
    t.string   "first_name"
    t.string   "last_name"
    t.boolean  "admin"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email"
  end

  add_foreign_key "notes", "categories", :name => "notes_category_id_fk"
  add_foreign_key "notes", "users", :name => "notes_add_user_id_fk", :column => "add_user_id"

end
