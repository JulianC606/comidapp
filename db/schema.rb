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

ActiveRecord::Schema[8.0].define(version: 2025_07_17_023822) do
  create_table "delegations", force: :cascade do |t|
    t.string "name"
    t.integer "participants_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "food_providers", force: :cascade do |t|
    t.string "name"
    t.boolean "default", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "participants_count"
  end

  create_table "food_restriction_participants", force: :cascade do |t|
    t.integer "food_restriction_id", null: false
    t.integer "participant_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["food_restriction_id"], name: "index_food_restriction_participants_on_food_restriction_id"
    t.index ["participant_id"], name: "index_food_restriction_participants_on_participant_id"
  end

  create_table "food_restrictions", force: :cascade do |t|
    t.string "name"
    t.string "kind"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "lunches", force: :cascade do |t|
    t.integer "participant_id", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "kind", default: "without_restrictions"
    t.date "delivery_date"
    t.integer "food_provider_id", null: false
    t.datetime "delivered_at"
    t.index ["food_provider_id"], name: "index_lunches_on_food_provider_id"
    t.index ["participant_id"], name: "index_lunches_on_participant_id"
    t.index ["user_id"], name: "index_lunches_on_user_id"
  end

  create_table "participants", force: :cascade do |t|
    t.string "name"
    t.string "restrictions"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "barcode"
    t.boolean "welcome_kit"
    t.string "role"
    t.integer "food_provider_id", null: false
    t.integer "delegation_id"
    t.index ["delegation_id"], name: "index_participants_on_delegation_id"
    t.index ["food_provider_id"], name: "index_participants_on_food_provider_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "ip_address"
    t.string "user_agent"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email_address", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.boolean "admin", default: false
    t.string "locale", default: "en"
    t.index ["email_address"], name: "index_users_on_email_address", unique: true
  end

  add_foreign_key "food_restriction_participants", "food_restrictions"
  add_foreign_key "food_restriction_participants", "participants"
  add_foreign_key "lunches", "food_providers"
  add_foreign_key "lunches", "participants"
  add_foreign_key "lunches", "users"
  add_foreign_key "participants", "delegations"
  add_foreign_key "participants", "food_providers"
  add_foreign_key "sessions", "users"
end
