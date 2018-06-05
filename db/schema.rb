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

ActiveRecord::Schema.define(version: 2018_06_05_190822) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "analyses", force: :cascade do |t|
    t.bigint "profile_id"
    t.text "analysis"
    t.date "received_at"
    t.boolean "operation_required"
    t.float "min_duration"
    t.float "max_duration"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["profile_id"], name: "index_analyses_on_profile_id"
  end

  create_table "operation_days", force: :cascade do |t|
    t.date "at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "operations", force: :cascade do |t|
    t.time "starts_at"
    t.time "ends_at"
    t.boolean "is_operated", default: false
    t.bigint "room_id"
    t.bigint "analysis_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "assigned", default: false
    t.index ["analysis_id"], name: "index_operations_on_analysis_id"
    t.index ["room_id"], name: "index_operations_on_room_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "surname"
    t.string "middlename"
    t.integer "age"
    t.integer "role"
    t.index ["email"], name: "index_profiles_on_email", unique: true
    t.index ["reset_password_token"], name: "index_profiles_on_reset_password_token", unique: true
  end

  create_table "rooms", force: :cascade do |t|
    t.float "capacity"
    t.string "name"
    t.string "info"
    t.bigint "operation_day_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["operation_day_id"], name: "index_rooms_on_operation_day_id"
  end

  add_foreign_key "analyses", "profiles"
  add_foreign_key "operations", "analyses"
  add_foreign_key "operations", "rooms"
  add_foreign_key "rooms", "operation_days"
end
