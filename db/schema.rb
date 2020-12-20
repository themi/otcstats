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

ActiveRecord::Schema.define(version: 2020_12_17_114852) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "graphs", force: :cascade do |t|
    t.bigint "organisation_id", null: false
    t.string "name"
    t.integer "item_number"
    t.string "short_name"
    t.string "defintion"
    t.string "value_title"
    t.string "field_titles"
    t.string "envisage_key"
    t.integer "active_state", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["organisation_id"], name: "index_graphs_on_organisation_id"
  end

  create_table "members", force: :cascade do |t|
    t.bigint "organisation_id", null: false
    t.integer "role", default: 0, null: false
    t.string "full_name"
    t.string "phone"
    t.string "address"
    t.string "training_level"
    t.string "processing_level"
    t.string "envisage_key"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_members_on_email", unique: true
    t.index ["organisation_id"], name: "index_members_on_organisation_id"
    t.index ["reset_password_token"], name: "index_members_on_reset_password_token", unique: true
  end

  create_table "organisations", force: :cascade do |t|
    t.string "name"
    t.string "envisage_key"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "statistics", force: :cascade do |t|
    t.bigint "organisation_id", null: false
    t.bigint "graph_id", null: false
    t.bigint "added_by_id"
    t.date "week_ending_at"
    t.float "value"
    t.string "fact_column_1"
    t.string "fact_column_2"
    t.string "fact_column_3"
    t.string "fact_column_4"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["graph_id"], name: "index_statistics_on_graph_id"
    t.index ["organisation_id"], name: "index_statistics_on_organisation_id"
  end

  add_foreign_key "graphs", "organisations"
  add_foreign_key "members", "organisations"
  add_foreign_key "statistics", "graphs"
  add_foreign_key "statistics", "organisations"
end
