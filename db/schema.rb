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

ActiveRecord::Schema.define(version: 2024_05_07_230156) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "indicators", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name"], name: "index_indicators_on_name", unique: true
  end

  create_table "match_indicators", force: :cascade do |t|
    t.bigint "player_id"
    t.bigint "indicator_id"
    t.bigint "match_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["indicator_id"], name: "index_match_indicators_on_indicator_id"
    t.index ["match_id"], name: "index_match_indicators_on_match_id"
    t.index ["player_id", "indicator_id", "match_id"], name: "index_match_indicators_on_player_indicator_and_match", unique: true
    t.index ["player_id"], name: "index_match_indicators_on_player_id"
  end

  create_table "matches", force: :cascade do |t|
    t.bigint "first_team_id"
    t.bigint "second_team_id"
    t.datetime "ended_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["first_team_id"], name: "index_matches_on_first_team_id"
    t.index ["second_team_id"], name: "index_matches_on_second_team_id"
  end

  create_table "players", force: :cascade do |t|
    t.string "name"
    t.string "surname"
    t.integer "player_number"
    t.bigint "team_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["player_number", "team_id"], name: "index_players_on_player_number_and_team_id", unique: true
    t.index ["team_id"], name: "index_players_on_team_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "name"
    t.string "country_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["name", "country_name"], name: "index_teams_on_name_and_country_name", unique: true
  end

  add_foreign_key "match_indicators", "indicators"
  add_foreign_key "match_indicators", "matches"
  add_foreign_key "match_indicators", "players"
  add_foreign_key "matches", "teams", column: "first_team_id"
  add_foreign_key "matches", "teams", column: "second_team_id"
  add_foreign_key "players", "teams"
end
