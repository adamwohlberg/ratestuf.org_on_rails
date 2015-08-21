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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150821191854) do

  create_table "categories", force: :cascade do |t|
    t.string   "category_name", limit: 255
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "categories_subcategories", id: false, force: :cascade do |t|
    t.integer  "category_id",    limit: 4
    t.integer  "subcategory_id", limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "categories_subcategories", ["category_id", "subcategory_id"], name: "subcategory_category_index", unique: true, using: :btree

  create_table "items", force: :cascade do |t|
    t.string   "item_name",  limit: 255
    t.string   "item_url",   limit: 255
    t.integer  "user_id",    limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "items_subcategories", id: false, force: :cascade do |t|
    t.integer  "item_id",        limit: 4
    t.integer  "subcategory_id", limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "items_subcategories", ["item_id", "subcategory_id"], name: "index_items_subcategories_on_item_id_and_subcategory_id", using: :btree

  create_table "ratings", force: :cascade do |t|
    t.integer  "rating_id",   limit: 4
    t.integer  "user_id",     limit: 4
    t.integer  "item_id",     limit: 4
    t.decimal  "x_rating",                  precision: 10, scale: 3
    t.decimal  "y_rating",                  precision: 10, scale: 3
    t.text     "text_rating", limit: 65535
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
  end

  create_table "subcategories", force: :cascade do |t|
    t.string   "subcategory_name",   limit: 255
    t.string   "subcategory_factor", limit: 255
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
