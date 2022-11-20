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

ActiveRecord::Schema[7.0].define(version: 2022_11_20_144000) do
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
    t.jsonb "state", default: {"hexes"=>{"A2"=>{"cost"=>"3", "type"=>"town", "built"=>[], "income"=>"7", "developped"=>false, "development"=>"0"}, "A3"=>{"cost"=>"1", "type"=>"field", "built"=>[], "income"=>"0", "developped"=>false, "development"=>"0"}, "A4"=>{"cost"=>"1", "type"=>"field", "built"=>[], "income"=>"0", "developped"=>false, "development"=>"0"}, "B2"=>{"cost"=>"1", "type"=>"field", "built"=>[], "income"=>"0", "developped"=>false, "development"=>"0"}, "B3"=>{"cost"=>"1", "type"=>"field", "built"=>[], "income"=>"0", "developped"=>false, "development"=>"0"}, "B4"=>{"cost"=>"1", "type"=>"field", "built"=>[], "income"=>"0", "developped"=>false, "development"=>"0"}, "B5"=>{"cost"=>"1", "type"=>"town", "built"=>[], "income"=>"2", "developped"=>false, "development"=>"2"}, "B6"=>{"cost"=>"1", "type"=>"field", "built"=>[], "income"=>"0", "developped"=>false, "development"=>"0"}, "C0"=>{"cost"=>"1", "type"=>"field", "built"=>[], "income"=>"0", "developped"=>false, "development"=>"0"}, "C1"=>{"cost"=>"1", "type"=>"field", "built"=>[], "income"=>"0", "developped"=>false, "development"=>"0"}, "C2"=>{"cost"=>"2", "type"=>"town", "built"=>[], "income"=>"1", "developped"=>false, "development"=>"2"}, "C3"=>{"cost"=>"1", "type"=>"field", "built"=>[], "income"=>"0", "developped"=>false, "development"=>"0"}, "C4"=>{"cost"=>"1", "type"=>"field", "built"=>[], "income"=>"0", "developped"=>false, "development"=>"0"}, "C5"=>{"cost"=>"1", "type"=>"field", "built"=>[], "income"=>"0", "developped"=>false, "development"=>"0"}, "C6"=>{"cost"=>"1", "type"=>"field", "built"=>[], "income"=>"0", "developped"=>false, "development"=>"0"}, "C7"=>{"cost"=>"1", "type"=>"field", "built"=>[], "income"=>"0", "developped"=>false, "development"=>"0"}, "D0"=>{"cost"=>"1", "type"=>"field", "built"=>[], "income"=>"0", "developped"=>false, "development"=>"0"}, "D1"=>{"cost"=>"1", "type"=>"field", "built"=>[], "income"=>"0", "developped"=>false, "development"=>"0"}, "D2"=>{"cost"=>"1", "type"=>"field", "built"=>[], "income"=>"0", "developped"=>false, "development"=>"0"}, "D3"=>{"cost"=>"1", "type"=>"town", "built"=>[], "income"=>"1", "developped"=>false, "development"=>"2"}, "D4"=>{"cost"=>"1", "type"=>"field", "built"=>[], "income"=>"0", "developped"=>false, "development"=>"0"}, "D5"=>{"cost"=>"1", "type"=>"field", "built"=>[], "income"=>"0", "developped"=>false, "development"=>"0"}, "D6"=>{"cost"=>"1", "type"=>"field", "built"=>[], "income"=>"0", "developped"=>false, "development"=>"0"}, "D7"=>{"cost"=>"2", "type"=>"town", "built"=>[], "income"=>"2", "developped"=>false, "development"=>"2"}, "E0"=>{"cost"=>"3", "type"=>"city", "built"=>[], "income"=>"1", "developped"=>false, "development"=>"x"}, "E1"=>{"cost"=>"1", "type"=>"field", "built"=>[], "income"=>"0", "developped"=>false, "development"=>"0"}, "E2"=>{"cost"=>"1", "type"=>"field", "built"=>[], "income"=>"0", "developped"=>false, "development"=>"0"}, "E3"=>{"cost"=>"1", "type"=>"field", "built"=>[], "income"=>"0", "developped"=>false, "development"=>"0"}, "E4"=>{"cost"=>"1", "type"=>"field", "built"=>[], "income"=>"0", "developped"=>false, "development"=>"0"}, "E5"=>{"cost"=>"1", "type"=>"field", "built"=>[], "income"=>"0", "developped"=>false, "development"=>"0"}, "E6"=>{"cost"=>"1", "type"=>"field", "built"=>[], "income"=>"0", "developped"=>false, "development"=>"0"}, "E7"=>{"cost"=>"1", "type"=>"field", "built"=>[], "income"=>"0", "developped"=>false, "development"=>"0"}, "E8"=>{"cost"=>"1", "type"=>"field", "built"=>[], "income"=>"0", "developped"=>false, "development"=>"0"}, "F1"=>{"cost"=>"2", "type"=>"town", "built"=>[], "income"=>"1", "developped"=>false, "development"=>"1"}, "F2"=>{"cost"=>"1", "type"=>"field", "built"=>[], "income"=>"0", "developped"=>false, "development"=>"0"}, "F3"=>{"cost"=>"1", "type"=>"field", "built"=>[], "income"=>"0", "developped"=>false, "development"=>"0"}, "F4"=>{"cost"=>"1", "type"=>"field", "built"=>[], "income"=>"0", "developped"=>false, "development"=>"0"}, "F5"=>{"cost"=>"1", "type"=>"town", "built"=>[], "income"=>"1", "developped"=>false, "development"=>"1"}, "F6"=>{"cost"=>"1", "type"=>"field", "built"=>[], "income"=>"0", "developped"=>false, "development"=>"0"}, "F7"=>{"cost"=>"1", "type"=>"field", "built"=>[], "income"=>"0", "developped"=>false, "development"=>"0"}, "F8"=>{"cost"=>"2", "type"=>"town", "built"=>[], "income"=>"2", "developped"=>false, "development"=>"1"}, "G2"=>{"cost"=>"1", "type"=>"field", "built"=>[], "income"=>"0", "developped"=>false, "development"=>"0"}, "G3"=>{"cost"=>"1", "type"=>"field", "built"=>[], "income"=>"0", "developped"=>false, "development"=>"0"}, "G4"=>{"cost"=>"1", "type"=>"field", "built"=>[], "income"=>"0", "developped"=>false, "development"=>"0"}, "G5"=>{"cost"=>"1", "type"=>"field", "built"=>[], "income"=>"0", "developped"=>false, "development"=>"0"}, "G6"=>{"cost"=>"1", "type"=>"field", "built"=>[], "income"=>"0", "developped"=>false, "development"=>"0"}, "G7"=>{"cost"=>"1", "type"=>"field", "built"=>[], "income"=>"0", "developped"=>false, "development"=>"0"}, "G8"=>{"cost"=>"2", "type"=>"forest", "built"=>[], "income"=>"0", "developped"=>false, "development"=>"0"}, "G9"=>{"cost"=>"3", "type"=>"mountain", "built"=>[], "income"=>"1", "developped"=>false, "development"=>"2"}, "H2"=>{"cost"=>"1", "type"=>"field", "built"=>[], "income"=>"0", "developped"=>false, "development"=>"0"}, "H3"=>{"cost"=>"1", "type"=>"field", "built"=>[], "income"=>"0", "developped"=>false, "development"=>"0"}, "H4"=>{"cost"=>"1", "type"=>"field", "built"=>[], "income"=>"0", "developped"=>false, "development"=>"0"}, "H5"=>{"cost"=>"1", "type"=>"field", "built"=>[], "income"=>"0", "developped"=>false, "development"=>"0"}, "H6"=>{"cost"=>"1", "type"=>"field", "built"=>[], "income"=>"0", "developped"=>false, "development"=>"0"}, "H7"=>{"cost"=>"2", "type"=>"forest", "built"=>[], "income"=>"0", "developped"=>false, "development"=>"0"}, "H8"=>{"cost"=>"2", "type"=>"forest", "built"=>[], "income"=>"0", "developped"=>false, "development"=>"0"}, "H9"=>{"cost"=>"3", "type"=>"mountain", "built"=>[], "income"=>"1", "developped"=>false, "development"=>"2"}, "I2"=>{"cost"=>"1", "type"=>"town", "built"=>[], "income"=>"2", "developped"=>false, "development"=>"2"}, "I3"=>{"cost"=>"1", "type"=>"field", "built"=>[], "income"=>"0", "developped"=>false, "development"=>"0"}, "I4"=>{"cost"=>"2", "type"=>"town", "built"=>[], "income"=>"1", "developped"=>false, "development"=>"1"}, "I5"=>{"cost"=>"2", "type"=>"forest", "built"=>[], "income"=>"0", "developped"=>false, "development"=>"0"}, "I6"=>{"cost"=>"3", "type"=>"city", "built"=>[], "income"=>"3", "developped"=>false, "development"=>"x"}, "I7"=>{"cost"=>"2", "type"=>"forest", "built"=>[], "income"=>"0", "developped"=>false, "development"=>"0"}, "I8"=>{"cost"=>"4", "type"=>"mountain", "built"=>[], "income"=>"1", "developped"=>false, "development"=>"2"}, "I9"=>{"cost"=>"3", "type"=>"town", "built"=>[], "income"=>"2", "developped"=>false, "development"=>"1"}, "J1"=>{"cost"=>"1", "type"=>"field", "built"=>[], "income"=>"0", "developped"=>false, "development"=>"0"}, "J2"=>{"cost"=>"1", "type"=>"forest", "built"=>[], "income"=>"0", "developped"=>false, "development"=>"0"}, "J3"=>{"cost"=>"2", "type"=>"forest", "built"=>[], "income"=>"0", "developped"=>false, "development"=>"0"}, "J4"=>{"cost"=>"2", "type"=>"forest", "built"=>[], "income"=>"0", "developped"=>false, "development"=>"0"}, "J5"=>{"cost"=>"2", "type"=>"forest", "built"=>[], "income"=>"0", "developped"=>false, "development"=>"0"}, "J6"=>{"cost"=>"3", "type"=>"mountain", "built"=>[], "income"=>"1", "developped"=>false, "development"=>"2"}, "J7"=>{"cost"=>"4", "type"=>"mountain", "built"=>[], "income"=>"1", "developped"=>false, "development"=>"2"}, "J8"=>{"cost"=>"4", "type"=>"mountain", "built"=>[], "income"=>"1", "developped"=>false, "development"=>"2"}, "J9"=>{"cost"=>"3", "type"=>"mountain", "built"=>[], "income"=>"1", "developped"=>false, "development"=>"2"}, "K1"=>{"cost"=>"1", "type"=>"field", "built"=>[], "income"=>"0", "developped"=>false, "development"=>"0"}, "K2"=>{"cost"=>"2", "type"=>"forest", "built"=>[], "income"=>"0", "developped"=>false, "development"=>"0"}, "K3"=>{"cost"=>"4", "type"=>"forest", "built"=>[], "income"=>"0", "developped"=>false, "development"=>"0"}, "K4"=>{"cost"=>"4", "type"=>"city", "built"=>[], "income"=>"4", "developped"=>false, "development"=>"x"}, "K5"=>{"cost"=>"4", "type"=>"forest", "built"=>[], "income"=>"0", "developped"=>false, "development"=>"0"}, "K6"=>{"cost"=>"4", "type"=>"mountain", "built"=>[], "income"=>"1", "developped"=>false, "development"=>"2"}, "K7"=>{"cost"=>"2", "type"=>"town", "built"=>[], "income"=>"1", "developped"=>false, "development"=>"1"}, "K8"=>{"cost"=>"4", "type"=>"mountain", "built"=>[], "income"=>"1", "developped"=>false, "development"=>"2"}, "K9"=>{"cost"=>"2", "type"=>"forest", "built"=>[], "income"=>"0", "developped"=>false, "development"=>"0"}, "L0"=>{"cost"=>"2", "type"=>"town", "built"=>[], "income"=>"3", "developped"=>false, "development"=>"2"}, "L1"=>{"cost"=>"1", "type"=>"field", "built"=>[], "income"=>"0", "developped"=>false, "development"=>"0"}, "L2"=>{"cost"=>"2", "type"=>"forest", "built"=>[], "income"=>"0", "developped"=>false, "development"=>"0"}, "L3"=>{"cost"=>"3", "type"=>"forest", "built"=>[], "income"=>"0", "developped"=>false, "development"=>"0"}, "L4"=>{"cost"=>"3", "type"=>"mountain", "built"=>[], "income"=>"1", "developped"=>false, "development"=>"2"}, "L5"=>{"cost"=>"4", "type"=>"mountain", "built"=>[], "income"=>"1", "developped"=>false, "development"=>"2"}, "L6"=>{"cost"=>"2", "type"=>"mountain", "built"=>[], "income"=>"1", "developped"=>false, "development"=>"2"}, "L7"=>{"cost"=>"3", "type"=>"forest", "built"=>[], "income"=>"0", "developped"=>false, "development"=>"0"}, "L8"=>{"cost"=>"2", "type"=>"forest", "built"=>[], "income"=>"0", "developped"=>false, "development"=>"0"}, "L9"=>{"cost"=>"1", "type"=>"field", "built"=>[], "income"=>"0", "developped"=>false, "development"=>"0"}, "M0"=>{"cost"=>"1", "type"=>"field", "built"=>[], "income"=>"0", "developped"=>false, "development"=>"0"}, "M1"=>{"cost"=>"2", "type"=>"forest", "built"=>[], "income"=>"0", "developped"=>false, "development"=>"0"}, "M2"=>{"cost"=>"2", "type"=>"forest", "built"=>[], "income"=>"0", "developped"=>false, "development"=>"0"}, "M3"=>{"cost"=>"3", "type"=>"forest", "built"=>[], "income"=>"0", "developped"=>false, "development"=>"0"}, "M4"=>{"cost"=>"2", "type"=>"town", "built"=>[], "income"=>"1", "developped"=>false, "development"=>"1"}, "M5"=>{"cost"=>"4", "type"=>"mountain", "built"=>[], "income"=>"1", "developped"=>false, "development"=>"2"}, "M6"=>{"cost"=>"2", "type"=>"mountain", "built"=>[], "income"=>"1", "developped"=>false, "development"=>"2"}, "M7"=>{"cost"=>"2", "type"=>"forest", "built"=>[], "income"=>"0", "developped"=>false, "development"=>"0"}, "M8"=>{"cost"=>"2", "type"=>"forest", "built"=>[], "income"=>"0", "developped"=>false, "development"=>"0"}, "M9"=>{"cost"=>"2", "type"=>"forest", "built"=>[], "income"=>"0", "developped"=>false, "development"=>"0"}, "N0"=>{"cost"=>"1", "type"=>"field", "built"=>[], "income"=>"0", "developped"=>false, "development"=>"0"}, "N1"=>{"cost"=>"3", "type"=>"forest", "built"=>[], "income"=>"0", "developped"=>false, "development"=>"0"}, "N2"=>{"cost"=>"3", "type"=>"forest", "built"=>[], "income"=>"0", "developped"=>false, "development"=>"0"}, "N3"=>{"cost"=>"2", "type"=>"forest", "built"=>[], "income"=>"0", "developped"=>false, "development"=>"0"}, "N4"=>{"cost"=>"3", "type"=>"mountain", "built"=>[], "income"=>"1", "developped"=>false, "development"=>"1"}, "N5"=>{"cost"=>"4", "type"=>"forest", "built"=>[], "income"=>"0", "developped"=>false, "development"=>"0"}, "N6"=>{"cost"=>"2", "type"=>"town", "built"=>[], "income"=>"1", "developped"=>false, "development"=>"1"}, "N7"=>{"cost"=>"2", "type"=>"forest", "built"=>[], "income"=>"0", "developped"=>false, "development"=>"0"}, "N8"=>{"cost"=>"2", "type"=>"field", "built"=>[], "income"=>"0", "developped"=>false, "development"=>"0"}, "N9"=>{"cost"=>"1", "type"=>"field", "built"=>[], "income"=>"0", "developped"=>false, "development"=>"0"}, "O0"=>{"cost"=>"2", "type"=>"town", "built"=>[], "income"=>"1", "developped"=>false, "development"=>"2"}, "O1"=>{"cost"=>"2", "type"=>"forest", "built"=>[], "income"=>"0", "developped"=>false, "development"=>"0"}, "O2"=>{"cost"=>"3", "type"=>"forest", "built"=>[], "income"=>"0", "developped"=>false, "development"=>"0"}, "O3"=>{"cost"=>"3", "type"=>"forest", "built"=>[], "income"=>"0", "developped"=>false, "development"=>"0"}, "O4"=>{"cost"=>"2", "type"=>"town", "built"=>[], "income"=>"1", "developped"=>false, "development"=>"1"}, "O5"=>{"cost"=>"2", "type"=>"field", "built"=>[], "income"=>"0", "developped"=>false, "development"=>"0"}, "O6"=>{"cost"=>"2", "type"=>"field", "built"=>[], "income"=>"0", "developped"=>false, "development"=>"0"}, "O7"=>{"cost"=>"1", "type"=>"field", "built"=>[], "income"=>"0", "developped"=>false, "development"=>"0"}, "O8"=>{"cost"=>"2", "type"=>"field", "built"=>[], "income"=>"0", "developped"=>false, "development"=>"0"}, "O9"=>{"cost"=>"2", "type"=>"forest", "built"=>[], "income"=>"0", "developped"=>false, "development"=>"0"}, "P0"=>{"cost"=>"1", "type"=>"field", "built"=>[], "income"=>"0", "developped"=>false, "development"=>"0"}, "P1"=>{"cost"=>"2", "type"=>"forest", "built"=>[], "income"=>"0", "developped"=>false, "development"=>"0"}, "P2"=>{"cost"=>"2", "type"=>"forest", "built"=>[], "income"=>"0", "developped"=>false, "development"=>"0"}, "P3"=>{"cost"=>"2", "type"=>"forest", "built"=>[], "income"=>"0", "developped"=>false, "development"=>"0"}, "P4"=>{"cost"=>"1", "type"=>"field", "built"=>[], "income"=>"0", "developped"=>false, "development"=>"0"}, "P5"=>{"cost"=>"1", "type"=>"field", "built"=>[], "income"=>"0", "developped"=>false, "development"=>"0"}, "P6"=>{"cost"=>"1", "type"=>"field", "built"=>[], "income"=>"0", "developped"=>false, "development"=>"0"}, "P7"=>{"cost"=>"1", "type"=>"field", "built"=>[], "income"=>"0", "developped"=>false, "development"=>"0"}, "P8"=>{"cost"=>"1", "type"=>"field", "built"=>[], "income"=>"0", "developped"=>false, "development"=>"0"}, "P9"=>{"cost"=>"1", "type"=>"field", "built"=>[], "income"=>"0", "developped"=>false, "development"=>"0"}, "Q0"=>{"cost"=>"2", "type"=>"town", "built"=>[], "income"=>"1", "developped"=>false, "development"=>"1"}, "Q1"=>{"cost"=>"2", "type"=>"forest", "built"=>[], "income"=>"0", "developped"=>false, "development"=>"0"}, "Q2"=>{"cost"=>"2", "type"=>"forest", "built"=>[], "income"=>"0", "developped"=>false, "development"=>"0"}, "Q3"=>{"cost"=>"2", "type"=>"town", "built"=>[], "income"=>"1", "developped"=>false, "development"=>"1"}, "Q4"=>{"cost"=>"2", "type"=>"forest", "built"=>[], "income"=>"0", "developped"=>false, "development"=>"0"}, "Q5"=>{"cost"=>"1", "type"=>"field", "built"=>[], "income"=>"0", "developped"=>false, "development"=>"0"}, "Q6"=>{"cost"=>"1", "type"=>"field", "built"=>[], "income"=>"0", "developped"=>false, "development"=>"0"}, "Q7"=>{"cost"=>"0", "type"=>"town", "built"=>["blue"], "income"=>"0", "developped"=>false, "development"=>"0"}, "Q8"=>{"cost"=>"1", "type"=>"field", "built"=>[], "income"=>"0", "developped"=>false, "development"=>"0"}, "Q9"=>{"cost"=>"0", "type"=>"town", "built"=>["yellow"], "income"=>"0", "developped"=>false, "development"=>"0"}, "R0"=>{"cost"=>"1", "type"=>"field", "built"=>[], "income"=>"0", "developped"=>false, "development"=>"0"}, "R1"=>{"cost"=>"2", "type"=>"forest", "built"=>[], "income"=>"0", "developped"=>false, "development"=>"0"}, "R2"=>{"cost"=>"2", "type"=>"forest", "built"=>[], "income"=>"0", "developped"=>false, "development"=>"0"}, "R3"=>{"cost"=>"2", "type"=>"forest", "built"=>[], "income"=>"0", "developped"=>false, "development"=>"0"}, "R4"=>{"cost"=>"1", "type"=>"field", "built"=>[], "income"=>"0", "developped"=>false, "development"=>"0"}, "R5"=>{"cost"=>"0", "type"=>"town", "built"=>["red"], "income"=>"0", "developped"=>false, "development"=>"0"}, "R6"=>{"cost"=>"1", "type"=>"field", "built"=>[], "income"=>"0", "developped"=>false, "development"=>"0"}, "S0"=>{"cost"=>"2", "type"=>"town", "built"=>[], "income"=>"1", "developped"=>false, "development"=>"2"}, "S1"=>{"cost"=>"1", "type"=>"field", "built"=>[], "income"=>"0", "developped"=>false, "development"=>"0"}, "S2"=>{"cost"=>"1", "type"=>"field", "built"=>[], "income"=>"0", "developped"=>false, "development"=>"0"}, "S3"=>{"cost"=>"0", "type"=>"town", "built"=>["green"], "income"=>"0", "developped"=>false, "development"=>"0"}, "S4"=>{"cost"=>"1", "type"=>"field", "built"=>[], "income"=>"0", "developped"=>false, "development"=>"0"}, "S5"=>{"cost"=>"1", "type"=>"field", "built"=>[], "income"=>"0", "developped"=>false, "development"=>"0"}, "I10"=>{"cost"=>"3", "type"=>"mountain", "built"=>[], "income"=>"1", "developped"=>false, "development"=>"2"}, "K10"=>{"cost"=>"2", "type"=>"town", "built"=>[], "income"=>"1", "developped"=>false, "development"=>"1"}, "M10"=>{"cost"=>"1", "type"=>"town", "built"=>[], "income"=>"1", "developped"=>false, "development"=>"1"}, "O10"=>{"cost"=>"2", "type"=>"town", "built"=>[], "income"=>"2", "developped"=>false, "development"=>"1"}}, "companies"=>{"red"=>{"money"=>0, "track"=>19, "income"=>7, "shares"=>3, "started"=>true, "start_hex"=>"R5", "built_track"=>["R5"], "shares_sold"=>0}, "blue"=>{"money"=>0, "track"=>21, "income"=>6, "shares"=>4, "started"=>true, "start_hex"=>"Q7", "built_track"=>["Q7"], "shares_sold"=>0}, "black"=>{"money"=>0, "track"=>11, "income"=>0, "shares"=>2, "started"=>false, "start_hex"=>"D3", "built_track"=>[], "shares_sold"=>0}, "green"=>{"money"=>0, "track"=>23, "income"=>5, "shares"=>5, "started"=>true, "start_hex"=>"S3", "built_track"=>["S3"], "shares_sold"=>0}, "yellow"=>{"money"=>0, "track"=>25, "income"=>8, "shares"=>6, "started"=>true, "start_hex"=>"Q9", "built_track"=>["Q9"], "shares_sold"=>0}}}, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "started", precision: nil
    t.bigint "user_id", null: false
    t.datetime "ended_at", precision: nil
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
