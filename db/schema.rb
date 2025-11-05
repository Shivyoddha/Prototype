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

ActiveRecord::Schema[7.1].define(version: 2024_01_01_000005) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "doc_as", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "eq_id", null: false
    t.string "name", null: false
    t.decimal "cost", precision: 10, scale: 2, null: false
    t.string "head", null: false
    t.datetime "u_date"
    t.text "u_remarks"
    t.datetime "p_date"
    t.text "p_remarks"
    t.datetime "q_date"
    t.text "q_remarks"
    t.datetime "r_date"
    t.text "r_remarks"
    t.datetime "s_date"
    t.text "s_remarks"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["eq_id"], name: "index_doc_as_on_eq_id", unique: true
    t.index ["user_id"], name: "index_doc_as_on_user_id"
  end

  create_table "doc_bs", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "eq_id", null: false
    t.string "name", null: false
    t.decimal "cost", precision: 10, scale: 2, null: false
    t.string "head", null: false
    t.text "proceedings", null: false
    t.datetime "u_date"
    t.text "u_remarks"
    t.datetime "p_date"
    t.text "p_remarks"
    t.datetime "q_date"
    t.text "q_remarks"
    t.datetime "r_date"
    t.text "r_remarks"
    t.datetime "s_date"
    t.text "s_remarks"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_doc_bs_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "user_id", null: false
    t.string "user_name", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "display_name"
    t.string "email"
    t.boolean "is_admin", default: false
    t.index ["email"], name: "index_users_on_email"
    t.index ["user_name"], name: "index_users_on_user_name", unique: true
  end

  add_foreign_key "doc_as", "users"
  add_foreign_key "doc_bs", "users"
end
