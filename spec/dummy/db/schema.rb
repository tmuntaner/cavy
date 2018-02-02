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

ActiveRecord::Schema.define(version: 20171121075213) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "cavy_groups_policies", id: false, force: :cascade do |t|
    t.bigint "cavy_group_id", null: false
    t.bigint "cavy_policy_id", null: false
  end

  create_table "cavy_groups_users", id: false, force: :cascade do |t|
    t.bigint "cavy_user_id", null: false
    t.bigint "cavy_group_id", null: false
  end

  create_table "cavy_page_templates", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "template"
    t.hstore "fields"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cavy_pages", id: :serial, force: :cascade do |t|
    t.hstore "title"
    t.hstore "data"
    t.string "render"
    t.string "route"
    t.json "page_elements"
    t.integer "cavy_page_template_id"
    t.hstore "seo_description"
    t.jsonb "seo_keywords"
  end

  create_table "cavy_resources", id: :serial, force: :cascade do |t|
    t.string "url"
    t.string "name"
    t.string "file_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["url"], name: "index_cavy_resources_on_url", unique: true
  end

  create_table "cavy_users", id: :serial, force: :cascade do |t|
    t.string "email"
    t.string "name"
    t.string "password_digest"
    t.string "auth_token"
    t.string "role"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_foreign_key "cavy_pages", "cavy_page_templates"
end
