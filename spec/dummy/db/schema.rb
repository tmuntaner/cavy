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

ActiveRecord::Schema.define(version: 20170206144114) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "cavy_groups", force: :cascade do |t|
    t.string   "name"
    t.boolean  "is_super_admin"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["name"], name: "index_cavy_groups_on_name", unique: true, using: :btree
  end

  create_table "cavy_groups_policies", id: false, force: :cascade do |t|
    t.integer "cavy_group_id",  null: false
    t.integer "cavy_policy_id", null: false
  end

  create_table "cavy_groups_users", id: false, force: :cascade do |t|
    t.integer "cavy_user_id",  null: false
    t.integer "cavy_group_id", null: false
  end

  create_table "cavy_item_groups", force: :cascade do |t|
    t.string "title"
    t.string "params", array: true
  end

  create_table "cavy_item_sections", force: :cascade do |t|
    t.string  "title"
    t.integer "item_groups", array: true
  end

  create_table "cavy_items", force: :cascade do |t|
    t.hstore  "data"
    t.integer "position"
    t.integer "item_group_id"
  end

  create_table "cavy_page_templates", force: :cascade do |t|
    t.string   "name"
    t.string   "template"
    t.hstore   "fields"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cavy_pages", force: :cascade do |t|
    t.hstore "title"
    t.hstore "content"
    t.hstore "data"
    t.string "render"
    t.string "route"
    t.text   "description"
    t.string "tags",          array: true
    t.json   "page_elements"
  end

  create_table "cavy_policies", force: :cascade do |t|
    t.string "name"
    t.index ["name"], name: "index_cavy_policies_on_name", unique: true, using: :btree
  end

  create_table "cavy_users", force: :cascade do |t|
    t.string   "email"
    t.string   "name"
    t.string   "password_digest"
    t.string   "auth_token"
    t.string   "role"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
