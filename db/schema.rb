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

ActiveRecord::Schema[7.0].define(version: 2022_11_10_102604) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "game_players", force: :cascade do |t|
    t.bigint "game_id", null: false
    t.bigint "user_id", null: false
    t.integer "seat"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_game_players_on_game_id"
    t.index ["user_id"], name: "index_game_players_on_user_id"
  end

  create_table "games", force: :cascade do |t|
    t.string "name"
    t.integer "min_players"
    t.integer "max_players"
    t.jsonb "state", default: {"hexes"=>{"A2"=>{"cost"=>"3", "type"=>"town"}, "A3"=>{"cost"=>"1", "type"=>"field"}, "A4"=>{"cost"=>"1", "type"=>"field"}, "B2"=>{"cost"=>"1", "type"=>"field"}, "B3"=>{"cost"=>"1", "type"=>"field"}, "B4"=>{"cost"=>"1", "type"=>"field"}, "B5"=>{"cost"=>"1", "type"=>"town"}, "B6"=>{"cost"=>"1", "type"=>"field"}, "C0"=>{"cost"=>"1", "type"=>"field"}, "C1"=>{"cost"=>"1", "type"=>"field"}, "C2"=>{"cost"=>"2", "type"=>"town"}, "C3"=>{"cost"=>"1", "type"=>"field"}, "C4"=>{"cost"=>"1", "type"=>"field"}, "C5"=>{"cost"=>"1", "type"=>"field"}, "C6"=>{"cost"=>"1", "type"=>"field"}, "C7"=>{"cost"=>"1", "type"=>"field"}, "D0"=>{"cost"=>"1", "type"=>"field"}, "D1"=>{"cost"=>"1", "type"=>"field"}, "D2"=>{"cost"=>"1", "type"=>"field"}, "D3"=>{"cost"=>"1", "type"=>"town"}, "D4"=>{"cost"=>"1", "type"=>"field"}, "D5"=>{"cost"=>"1", "type"=>"field"}, "D6"=>{"cost"=>"1", "type"=>"field"}, "D7"=>{"cost"=>"2", "type"=>"town"}, "E0"=>{"cost"=>"3", "type"=>"city"}, "E1"=>{"cost"=>"1", "type"=>"field"}, "E2"=>{"cost"=>"1", "type"=>"field"}, "E3"=>{"cost"=>"1", "type"=>"field"}, "E4"=>{"cost"=>"1", "type"=>"field"}, "E5"=>{"cost"=>"1", "type"=>"field"}, "E6"=>{"cost"=>"1", "type"=>"field"}, "E7"=>{"cost"=>"1", "type"=>"field"}, "E8"=>{"cost"=>"1", "type"=>"field"}, "F1"=>{"cost"=>"2", "type"=>"town"}, "F2"=>{"cost"=>"1", "type"=>"field"}, "F3"=>{"cost"=>"1", "type"=>"field"}, "F4"=>{"cost"=>"1", "type"=>"field"}, "F5"=>{"cost"=>"1", "type"=>"town"}, "F6"=>{"cost"=>"1", "type"=>"field"}, "F7"=>{"cost"=>"1", "type"=>"field"}, "F8"=>{"cost"=>"2", "type"=>"town"}, "G2"=>{"cost"=>"1", "type"=>"field"}, "G3"=>{"cost"=>"1", "type"=>"field"}, "G4"=>{"cost"=>"1", "type"=>"field"}, "G5"=>{"cost"=>"1", "type"=>"field"}, "G6"=>{"cost"=>"1", "type"=>"field"}, "G7"=>{"cost"=>"1", "type"=>"field"}, "G8"=>{"cost"=>"2", "type"=>"forest"}, "G9"=>{"cost"=>"3", "type"=>"mountain"}, "H2"=>{"cost"=>"1", "type"=>"field"}, "H3"=>{"cost"=>"1", "type"=>"field"}, "H4"=>{"cost"=>"1", "type"=>"field"}, "H5"=>{"cost"=>"1", "type"=>"field"}, "H6"=>{"cost"=>"1", "type"=>"field"}, "H7"=>{"cost"=>"2", "type"=>"forest"}, "H8"=>{"cost"=>"2", "type"=>"forest"}, "H9"=>{"cost"=>"3", "type"=>"mountain"}, "I2"=>{"cost"=>"1", "type"=>"town"}, "I3"=>{"cost"=>"1", "type"=>"field"}, "I4"=>{"cost"=>"2", "type"=>"town"}, "I5"=>{"cost"=>"2", "type"=>"forest"}, "I6"=>{"cost"=>"3", "type"=>"city"}, "I7"=>{"cost"=>"2", "type"=>"forest"}, "I8"=>{"cost"=>"4", "type"=>"mountain"}, "I9"=>{"cost"=>"3", "type"=>"town"}, "J1"=>{"cost"=>"1", "type"=>"field"}, "J2"=>{"cost"=>"1", "type"=>"forest"}, "J3"=>{"cost"=>"2", "type"=>"forest"}, "J4"=>{"cost"=>"2", "type"=>"forest"}, "J5"=>{"cost"=>"2", "type"=>"forest"}, "J6"=>{"cost"=>"3", "type"=>"mountain"}, "J7"=>{"cost"=>"4", "type"=>"mountain"}, "J8"=>{"cost"=>"4", "type"=>"mountain"}, "J9"=>{"cost"=>"3", "type"=>"mountain"}, "K1"=>{"cost"=>"1", "type"=>"field"}, "K2"=>{"cost"=>"2", "type"=>"forest"}, "K3"=>{"cost"=>"4", "type"=>"forest"}, "K4"=>{"cost"=>"4", "type"=>"city"}, "K5"=>{"cost"=>"4", "type"=>"forest"}, "K6"=>{"cost"=>"4", "type"=>"mountain"}, "K7"=>{"cost"=>"2", "type"=>"town"}, "K8"=>{"cost"=>"4", "type"=>"mountain"}, "K9"=>{"cost"=>"2", "type"=>"forest"}, "L0"=>{"cost"=>"2", "type"=>"town"}, "L1"=>{"cost"=>"1", "type"=>"field"}, "L2"=>{"cost"=>"2", "type"=>"forest"}, "L3"=>{"cost"=>"3", "type"=>"forest"}, "L4"=>{"cost"=>"3", "type"=>"mountain"}, "L5"=>{"cost"=>"4", "type"=>"mountain"}, "L6"=>{"cost"=>"2", "type"=>"mountain"}, "L7"=>{"cost"=>"3", "type"=>"forest"}, "L8"=>{"cost"=>"2", "type"=>"forest"}, "L9"=>{"cost"=>"1", "type"=>"field"}, "M0"=>{"cost"=>"1", "type"=>"field"}, "M1"=>{"cost"=>"2", "type"=>"forest"}, "M2"=>{"cost"=>"2", "type"=>"forest"}, "M3"=>{"cost"=>"3", "type"=>"forest"}, "M4"=>{"cost"=>"2", "type"=>"town"}, "M5"=>{"cost"=>"4", "type"=>"mountain"}, "M6"=>{"cost"=>"2", "type"=>"mountain"}, "M7"=>{"cost"=>"2", "type"=>"forest"}, "M8"=>{"cost"=>"2", "type"=>"forest"}, "M9"=>{"cost"=>"2", "type"=>"forest"}, "N0"=>{"cost"=>"1", "type"=>"field"}, "N1"=>{"cost"=>"3", "type"=>"forest"}, "N2"=>{"cost"=>"3", "type"=>"forest"}, "N3"=>{"cost"=>"2", "type"=>"forest"}, "N4"=>{"cost"=>"3", "type"=>"mountain"}, "N5"=>{"cost"=>"4", "type"=>"forest"}, "N6"=>{"cost"=>"2", "type"=>"town"}, "N7"=>{"cost"=>"2", "type"=>"forest"}, "N8"=>{"cost"=>"2", "type"=>"field"}, "N9"=>{"cost"=>"1", "type"=>"field"}, "O0"=>{"cost"=>"2", "type"=>"town"}, "O1"=>{"cost"=>"2", "type"=>"forest"}, "O2"=>{"cost"=>"3", "type"=>"forest"}, "O3"=>{"cost"=>"3", "type"=>"forest"}, "O4"=>{"cost"=>"2", "type"=>"town"}, "O5"=>{"cost"=>"2", "type"=>"field"}, "O6"=>{"cost"=>"2", "type"=>"field"}, "O7"=>{"cost"=>"1", "type"=>"field"}, "O8"=>{"cost"=>"2", "type"=>"field"}, "O9"=>{"cost"=>"2", "type"=>"forest"}, "P0"=>{"cost"=>"1", "type"=>"field"}, "P1"=>{"cost"=>"2", "type"=>"forest"}, "P2"=>{"cost"=>"2", "type"=>"forest"}, "P3"=>{"cost"=>"2", "type"=>"forest"}, "P4"=>{"cost"=>"1", "type"=>"field"}, "P5"=>{"cost"=>"1", "type"=>"field"}, "P6"=>{"cost"=>"1", "type"=>"field"}, "P7"=>{"cost"=>"1", "type"=>"field"}, "P8"=>{"cost"=>"1", "type"=>"field"}, "P9"=>{"cost"=>"1", "type"=>"field"}, "Q0"=>{"cost"=>"2", "type"=>"town"}, "Q1"=>{"cost"=>"2", "type"=>"forest"}, "Q2"=>{"cost"=>"2", "type"=>"forest"}, "Q3"=>{"cost"=>"2", "type"=>"town"}, "Q4"=>{"cost"=>"2", "type"=>"forest"}, "Q5"=>{"cost"=>"1", "type"=>"field"}, "Q6"=>{"cost"=>"1", "type"=>"field"}, "Q7"=>{"cost"=>"0", "type"=>"town", "built"=>["blue"]}, "Q8"=>{"cost"=>"1", "type"=>"field"}, "Q9"=>{"cost"=>"0", "type"=>"town", "built"=>["yellow"]}, "R0"=>{"cost"=>"1", "type"=>"field"}, "R1"=>{"cost"=>"2", "type"=>"forest"}, "R2"=>{"cost"=>"2", "type"=>"forest"}, "R3"=>{"cost"=>"2", "type"=>"forest"}, "R4"=>{"cost"=>"1", "type"=>"field"}, "R5"=>{"cost"=>"0", "type"=>"town", "built"=>["red"]}, "R6"=>{"cost"=>"1", "type"=>"field"}, "S0"=>{"cost"=>"2", "type"=>"town"}, "S1"=>{"cost"=>"1", "type"=>"field"}, "S2"=>{"cost"=>"1", "type"=>"field"}, "S3"=>{"cost"=>"0", "type"=>"town", "built"=>["green"]}, "S4"=>{"cost"=>"1", "type"=>"field"}, "S5"=>{"cost"=>"1", "type"=>"field"}, "I10"=>{"cost"=>"3", "type"=>"mountain"}, "K10"=>{"cost"=>"2", "type"=>"town"}, "M10"=>{"cost"=>"1", "type"=>"town"}, "O10"=>{"cost"=>"2", "type"=>"town"}}, "companies"=>{"red"=>{"money"=>0, "track"=>19, "shares"=>3, "started"=>true, "start_hex"=>"R5"}, "blue"=>{"money"=>0, "track"=>21, "shares"=>4, "started"=>true, "start_hex"=>"Q7"}, "black"=>{"money"=>0, "track"=>11, "shares"=>2, "started"=>false, "start_hex"=>"D3"}, "green"=>{"money"=>0, "track"=>23, "shares"=>5, "started"=>true, "start_hex"=>"S3"}, "yellow"=>{"money"=>0, "track"=>25, "shares"=>6, "started"=>true, "start_hex"=>"Q9"}}}, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "started", precision: nil
    t.bigint "user_id", null: false
    t.index ["state"], name: "index_games_on_state", using: :gin
    t.index ["user_id"], name: "index_games_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "game_players", "games"
  add_foreign_key "game_players", "users"
  add_foreign_key "games", "users"
end
