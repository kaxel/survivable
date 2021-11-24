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

ActiveRecord::Schema.define(version: 2021_11_24_024811) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "adjustments", force: :cascade do |t|
    t.string "bonus"
    t.integer "amount", limit: 2
    t.bigint "project_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["project_id"], name: "index_adjustments_on_project_id"
  end

  create_table "climates", force: :cascade do |t|
    t.string "name"
    t.integer "cold_warm", limit: 2
    t.integer "cold_floor", limit: 2
    t.integer "warm_ceiling", limit: 2
    t.integer "intensity", limit: 2
    t.integer "trend", limit: 2
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "collections", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "collections_projects", id: false, force: :cascade do |t|
    t.bigint "collection_id", null: false
    t.bigint "project_id", null: false
  end

  create_table "current_games", force: :cascade do |t|
    t.string "sig"
    t.string "ip"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "survivalist_id", null: false
    t.bigint "user_id", null: false
    t.index ["survivalist_id"], name: "index_current_games_on_survivalist_id"
    t.index ["user_id"], name: "index_current_games_on_user_id"
  end

  create_table "days", force: :cascade do |t|
    t.integer "hour", limit: 2
    t.bigint "event_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "current_game_id", null: false
    t.index ["current_game_id"], name: "index_days_on_current_game_id"
    t.index ["event_id"], name: "index_days_on_event_id"
  end

  create_table "events", force: :cascade do |t|
    t.string "name"
    t.integer "length"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "current_game_id", null: false
    t.boolean "hidden", default: false
    t.index ["current_game_id"], name: "index_events_on_current_game_id"
  end

  create_table "locations", force: :cascade do |t|
    t.string "name"
    t.bigint "climate_id", null: false
    t.bigint "collection_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["climate_id"], name: "index_locations_on_climate_id"
    t.index ["collection_id"], name: "index_locations_on_collection_id"
  end

  create_table "possessions", force: :cascade do |t|
    t.string "name"
    t.string "bonus"
    t.bigint "current_game_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "quantity", limit: 2, default: 1
    t.bigint "project_id", null: false
    t.index ["current_game_id"], name: "index_possessions_on_current_game_id"
    t.index ["project_id"], name: "index_possessions_on_project_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "projects_requirements", id: false, force: :cascade do |t|
    t.bigint "project_id", null: false
    t.bigint "requirement_id", null: false
  end

  create_table "requirements", force: :cascade do |t|
    t.integer "amount", limit: 2
    t.bigint "resource_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
    t.index ["resource_id"], name: "index_requirements_on_resource_id"
  end

  create_table "resources", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "survivalists", force: :cascade do |t|
    t.integer "strength", limit: 2
    t.integer "creativity", limit: 2
    t.integer "determination", limit: 2
    t.integer "optimism", limit: 2
    t.integer "skill", limit: 2
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_survivalists_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.boolean "admin"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "adjustments", "projects"
  add_foreign_key "current_games", "survivalists"
  add_foreign_key "current_games", "users"
  add_foreign_key "days", "current_games"
  add_foreign_key "days", "events"
  add_foreign_key "events", "current_games"
  add_foreign_key "locations", "climates"
  add_foreign_key "locations", "collections"
  add_foreign_key "possessions", "current_games"
  add_foreign_key "possessions", "projects"
  add_foreign_key "requirements", "resources"
  add_foreign_key "survivalists", "users"
end
