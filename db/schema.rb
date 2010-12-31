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

ActiveRecord::Schema.define(:version => 20110117193323) do

  create_table "annotations", :force => true do |t|
    t.text     "body"
    t.integer  "book_id"
    t.integer  "page_number"
    t.integer  "line_number"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "original_url"
    t.string   "title"
  end

  add_index "annotations", ["book_id"], :name => "index_annotations_on_book_id"

  create_table "books", :force => true do |t|
    t.string   "title"
    t.string   "original_url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
    t.string   "amazon_url"
  end

  add_index "books", ["slug"], :name => "index_books_on_slug", :unique => true

end
