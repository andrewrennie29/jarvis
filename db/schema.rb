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

ActiveRecord::Schema.define(version: 20150204203124) do

  create_table "todos", force: true do |t|
    t.text     "todo_item"
    t.string   "todo_for"
    t.date     "todo_deadline"
    t.integer  "todo_importance"
    t.decimal  "todo_urgence",       precision: 10, scale: 4
    t.decimal  "todo_timerequired",  precision: 10, scale: 4
    t.boolean  "todo_recurring"
    t.string   "todo_frequency"
    t.decimal  "todo_status",        precision: 10, scale: 4
    t.decimal  "todo_timeremaining", precision: 10, scale: 4
    t.decimal  "todo_ranking",       precision: 10, scale: 4
    t.boolean  "todo_complete"
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.string   "todo_category"
    t.string   "todo_project"
    t.string   "todo_user"
    t.date     "todo_enddate"
    t.time     "todo_deadlinetime"
  end

  create_table "users", force: true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "password_hash"
    t.string   "password_salt"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
