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

ActiveRecord::Schema.define(version: 20150108171950) do

  create_table "todos", force: :cascade do |t|
    t.text     "todo_item",          limit: 65535
    t.string   "todo_for",           limit: 255
    t.datetime "todo_deadline"
    t.integer  "todo_importance",    limit: 4
    t.integer  "todo_urgence",       limit: 4
    t.decimal  "todo_timerequired",                precision: 10, scale: 4
    t.boolean  "todo_recurring",     limit: 1
    t.string   "todo_frequency",     limit: 255
    t.decimal  "todo_status",                      precision: 10, scale: 4
    t.decimal  "todo_timeremaining",               precision: 10, scale: 4
    t.decimal  "todo_ranking",                     precision: 10, scale: 4
    t.boolean  "todo_complete",      limit: 1
    t.datetime "created_at",                                                null: false
    t.datetime "updated_at",                                                null: false
    t.string   "todo_category",      limit: 255
    t.string   "todo_project",       limit: 255
    t.string   "todo_user",          limit: 255
    t.date     "todo_enddate"
  end

end
