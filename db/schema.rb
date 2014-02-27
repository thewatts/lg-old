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

ActiveRecord::Schema.define(version: 20140227011055) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "group_leaders", force: true do |t|
    t.integer  "user_id"
    t.integer  "lifegroup_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "group_leaders", ["lifegroup_id"], name: "index_group_leaders_on_lifegroup_id", using: :btree
  add_index "group_leaders", ["user_id"], name: "index_group_leaders_on_user_id", using: :btree

  create_table "lifegroups", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.integer  "semester_id"
    t.text     "description"
    t.text     "completed_steps"
    t.string   "number"
    t.boolean  "private"
    t.string   "privacy",         default: "open"
  end

  add_index "lifegroups", ["semester_id"], name: "index_lifegroups_on_semester_id", using: :btree

  create_table "semesters", force: true do |t|
    t.string   "name"
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "nickname"
    t.string   "provider"
    t.string   "uid"
    t.string   "image"
    t.string   "email"
    t.string   "display_name"
  end

end
