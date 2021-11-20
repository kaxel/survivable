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

ActiveRecord::Schema.define(version: 2021_11_20_230905) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "current_games", force: :cascade do |t|
    t.string "sig"
    t.string "ip"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "survivalist_id", null: false
    t.index ["survivalist_id"], name: "index_current_games_on_survivalist_id"
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

  create_table "survivalists", force: :cascade do |t|
    t.integer "strength", limit: 2
    t.integer "creativity", limit: 2
    t.integer "determination", limit: 2
    t.integer "optimism", limit: 2
    t.integer "skill", limit: 2
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name"
  end

  add_foreign_key "current_games", "survivalists"
  add_foreign_key "days", "current_games"
  add_foreign_key "days", "events"
  add_foreign_key "events", "current_games"
end
