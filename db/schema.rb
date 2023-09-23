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

ActiveRecord::Schema[7.0].define(version: 2023_09_23_061044) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string "first_name"
    t.string "middle_name"
    t.string "last_name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.index ["email"], name: "index_admins_on_email", unique: true
  end

  create_table "answer_sheets", force: :cascade do |t|
    t.integer "score", default: 0
    t.bigint "quiz_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["quiz_id"], name: "index_answer_sheets_on_quiz_id"
    t.index ["user_id"], name: "index_answer_sheets_on_user_id"
  end

  create_table "quiz_answers", force: :cascade do |t|
    t.string "answer", default: "unknown"
    t.bigint "quiz_item_id", null: false
    t.bigint "answer_sheet_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["answer_sheet_id"], name: "index_quiz_answers_on_answer_sheet_id"
    t.index ["quiz_item_id"], name: "index_quiz_answers_on_quiz_item_id"
  end

  create_table "quiz_items", force: :cascade do |t|
    t.text "problem"
    t.string "answer"
    t.integer "point", default: 0
    t.bigint "quiz_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["quiz_id"], name: "index_quiz_items_on_quiz_id"
  end

  create_table "quizzes", force: :cascade do |t|
    t.string "difficulty"
    t.integer "score", default: 0
    t.bigint "topic_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["topic_id"], name: "index_quizzes_on_topic_id"
  end

  create_table "subjects", force: :cascade do |t|
    t.string "name"
    t.bigint "admin_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["admin_id"], name: "index_subjects_on_admin_id"
    t.index ["name"], name: "index_subjects_on_name", unique: true
  end

  create_table "topics", force: :cascade do |t|
    t.string "name"
    t.text "discussion"
    t.bigint "subject_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_topics_on_name", unique: true
    t.index ["subject_id"], name: "index_topics_on_subject_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "middle_name"
    t.string "last_name"
    t.string "email"
    t.decimal "credibility", default: "0.0"
    t.bigint "admin_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.index ["admin_id"], name: "index_users_on_admin_id"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "answer_sheets", "quizzes"
  add_foreign_key "answer_sheets", "users"
  add_foreign_key "quiz_answers", "answer_sheets"
  add_foreign_key "quiz_answers", "quiz_items"
  add_foreign_key "quiz_items", "quizzes"
  add_foreign_key "quizzes", "topics"
  add_foreign_key "subjects", "admins"
  add_foreign_key "topics", "subjects"
  add_foreign_key "users", "admins"
end
