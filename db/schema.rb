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

ActiveRecord::Schema[8.1].define(version: 2026_03_23_183620) do
  create_table "deals", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "hubspot_id"
    t.date "last_seen"
    t.integer "listing_num"
    t.string "status"
    t.string "summary"
    t.string "title"
    t.datetime "updated_at", null: false
    t.index ["listing_num"], name: "index_deals_on_listing_num", unique: true
  end
end
