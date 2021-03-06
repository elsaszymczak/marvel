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

ActiveRecord::Schema.define(version: 2018_11_26_104909) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "characters", force: :cascade do |t|
    t.string "photo"
    t.string "name"
    t.bigint "event_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "marvel_id"
    t.string "cover_picture"
    t.index ["event_id"], name: "index_characters_on_event_id"
  end

  create_table "comic_characters", force: :cascade do |t|
    t.bigint "comic_id"
    t.bigint "character_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["character_id"], name: "index_comic_characters_on_character_id"
    t.index ["comic_id"], name: "index_comic_characters_on_comic_id"
  end

  create_table "comics", force: :cascade do |t|
    t.string "photo"
    t.string "name"
    t.bigint "event_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "marvel_id"
    t.string "cover_picture"
    t.index ["event_id"], name: "index_comics_on_event_id"
  end

  create_table "events", force: :cascade do |t|
    t.string "name"
    t.string "wiki_link"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "photo"
    t.string "cover_picture"
    t.integer "marvel_id"
    t.date "start_date"
    t.date "end_date"
  end

  add_foreign_key "characters", "events"
  add_foreign_key "comic_characters", "characters"
  add_foreign_key "comic_characters", "comics"
  add_foreign_key "comics", "events"
end
