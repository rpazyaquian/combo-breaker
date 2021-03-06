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

ActiveRecord::Schema.define(version: 20141020211906) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: true do |t|
    t.string   "display_name"
    t.string   "search_value"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "categories_locations", force: true do |t|
    t.integer "location_id"
    t.integer "category_id"
  end

  add_index "categories_locations", ["category_id"], name: "index_categories_locations_on_category_id", using: :btree
  add_index "categories_locations", ["location_id"], name: "index_categories_locations_on_location_id", using: :btree

  create_table "locations", force: true do |t|
    t.string   "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "locations_categories", id: false, force: true do |t|
    t.integer "location_id"
    t.integer "category_id"
  end

  add_index "locations_categories", ["category_id"], name: "index_locations_categories_on_category_id", using: :btree
  add_index "locations_categories", ["location_id"], name: "index_locations_categories_on_location_id", using: :btree

  create_table "meals", force: true do |t|
    t.string   "cuisine"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "meals", ["user_id"], name: "index_meals_on_user_id", using: :btree

  create_table "search_forms", force: true do |t|
    t.string   "location"
    t.string   "cuisine"
    t.integer  "radius_distance"
    t.string   "radius_units"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "users", force: true do |t|
    t.string "email"
    t.string "name"
    t.string "password_digest"
  end

end
