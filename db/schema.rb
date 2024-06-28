# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_06_28_100102) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "habit_statics", force: :cascade do |t|
    t.bigint "habit_id", null: false
    t.integer "total_occurrences", default: 0
    t.integer "completed_occurrences", default: 0
    t.integer "missed_occurrences", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["habit_id"], name: "index_habit_statics_on_habit_id"
  end

  create_table "habits", force: :cascade do |t|
    t.string "name"
    t.integer "priority"
    t.date "start_date"
    t.date "end_date"
    t.time "reminder"
    t.string "frequency"
    t.string "status"
    t.string "category"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "days_of_week", default: ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"], array: true
    t.text "description"
    t.index ["user_id"], name: "index_habits_on_user_id"
  end

  create_table "occurrences", force: :cascade do |t|
    t.string "completion_status", default: "pending"
    t.date "date"
    t.bigint "habit_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["habit_id"], name: "index_occurrences_on_habit_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.boolean "guest", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "habit_statics", "habits"
  add_foreign_key "habits", "users"
  add_foreign_key "occurrences", "habits"
end
