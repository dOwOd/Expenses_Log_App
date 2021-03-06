# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_02_07_140742) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "expenses", force: :cascade do |t|
    t.string "name", limit: 30, null: false
    t.integer "expense", null: false
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "paid_at", null: false
    t.bigint "user_id", null: false
    t.string "friendly_url"
    t.index ["friendly_url"], name: "index_expenses_on_friendly_url", unique: true
    t.index ["user_id"], name: "index_expenses_on_user_id"
  end

  create_table "group_expenses", force: :cascade do |t|
    t.bigint "group_id"
    t.bigint "expense_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["expense_id"], name: "index_group_expenses_on_expense_id"
    t.index ["group_id"], name: "index_group_expenses_on_group_id"
  end

  create_table "group_users", force: :cascade do |t|
    t.bigint "group_id"
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["group_id"], name: "index_group_users_on_group_id"
    t.index ["user_id"], name: "index_group_users_on_user_id"
  end

  create_table "groups", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "friendly_url"
    t.index ["friendly_url"], name: "index_groups_on_friendly_url", unique: true
  end

  create_table "user_settings", force: :cascade do |t|
    t.integer "percentage_of_expenses"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "group_user_id"
    t.index ["group_user_id"], name: "index_user_settings_on_group_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "screen_name", null: false
    t.string "email", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "invite_digest"
    t.integer "invited_by"
    t.datetime "invite_sent_at"
    t.integer "inviter"
    t.boolean "is_used"
    t.string "friendly_url"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["friendly_url"], name: "index_users_on_friendly_url", unique: true
  end

  add_foreign_key "group_expenses", "expenses"
  add_foreign_key "group_expenses", "groups"
  add_foreign_key "group_users", "groups"
  add_foreign_key "group_users", "users"
  add_foreign_key "user_settings", "group_users"
end
