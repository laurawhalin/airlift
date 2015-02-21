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

ActiveRecord::Schema.define(version: 20150220234116) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "item_categories", force: :cascade do |t|
    t.integer  "item_id"
    t.integer  "category_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "item_categories", ["category_id"], name: "index_item_categories_on_category_id", using: :btree
  add_index "item_categories", ["item_id"], name: "index_item_categories_on_item_id", using: :btree

  create_table "items", force: :cascade do |t|
    t.string   "title"
    t.string   "description"
    t.integer  "price"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.boolean  "retired"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "supplier_id"
    t.integer  "quantity",           default: 0
  end

  add_index "items", ["supplier_id"], name: "index_items_on_supplier_id", using: :btree

  create_table "orders", force: :cascade do |t|
    t.string   "status"
    t.integer  "total"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
  end

  create_table "orders_items", force: :cascade do |t|
    t.integer  "item_id"
    t.integer  "order_id"
    t.integer  "quantity"
    t.integer  "subtotal"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "supplier_admins", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "supplier_id"
  end

  add_index "supplier_admins", ["supplier_id"], name: "index_supplier_admins_on_supplier_id", using: :btree
  add_index "supplier_admins", ["user_id"], name: "index_supplier_admins_on_user_id", using: :btree

  create_table "suppliers", force: :cascade do |t|
    t.string   "name"
    t.string   "slug"
    t.string   "description"
    t.boolean  "retired"
    t.string   "address"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "fullname"
    t.string   "email"
    t.integer  "role",               default: 0
    t.string   "display_name"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "password_digest"
    t.string   "image"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  add_foreign_key "item_categories", "categories"
  add_foreign_key "item_categories", "items"
  add_foreign_key "supplier_admins", "users"
end
