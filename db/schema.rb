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

ActiveRecord::Schema[7.0].define(version: 2023_10_10_150924) do
  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "description"
  end

  create_table "exams", force: :cascade do |t|
    t.integer "pointExam"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "category_id"
    t.index ["category_id"], name: "index_exams_on_category_id", unique: true
  end

  create_table "exams_profiles", id: false, force: :cascade do |t|
    t.integer "exams_id"
    t.integer "profiles_id"
    t.index ["exams_id", "profiles_id"], name: "index_exams_profiles_on_exams_id_and_profiles_id", unique: true
    t.index ["exams_id"], name: "index_exams_profiles_on_exams_id"
    t.index ["profiles_id"], name: "index_exams_profiles_on_profiles_id"
  end

  create_table "levels", force: :cascade do |t|
    t.string "name"
    t.integer "numLevel"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "category_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.string "description"
    t.string "photo"
    t.integer "totalPoints"
    t.string "achievement"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_profiles_on_user_id", unique: true
  end

  create_table "questions", force: :cascade do |t|
    t.string "question"
    t.string "answer"
    t.string "wrongAnswer1"
    t.string "wrongAnswer3"
    t.integer "pointQuestion"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "exam_id"
    t.integer "level_id"
    t.string "wrongAnswer2"
  end

  create_table "rankings", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.integer "points"
    t.index ["user_id"], name: "index_rankings_on_user_id", unique: true
  end

  create_table "record_exams", force: :cascade do |t|
    t.integer "record_id", null: false
    t.integer "exam_id", null: false
    t.integer "point"
    t.integer "tries"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["exam_id"], name: "index_record_exams_on_exam_id"
    t.index ["record_id"], name: "index_record_exams_on_record_id"
  end

  create_table "record_levels", force: :cascade do |t|
    t.integer "level_id", null: false
    t.integer "total_points"
    t.integer "total_tries"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "record_id", null: false
    t.index ["level_id"], name: "index_record_levels_on_level_id"
    t.index ["record_id"], name: "index_record_levels_on_record_id"
  end

  create_table "record_questions", force: :cascade do |t|
    t.integer "record_id", null: false
    t.integer "question_id", null: false
    t.integer "points"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "wrong", default: true
    t.integer "questions_id"
    t.index ["question_id"], name: "index_record_questions_on_question_id"
    t.index ["record_id"], name: "index_record_questions_on_record_id"
  end

  create_table "records", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.index ["user_id"], name: "index_records_on_user_id"
  end

  create_table "supports", force: :cascade do |t|
    t.string "help"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password"
    t.string "username"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "levels", "categories"
  add_foreign_key "profiles", "users"
  add_foreign_key "questions", "exams"
  add_foreign_key "questions", "levels"
  add_foreign_key "record_exams", "exams"
  add_foreign_key "record_exams", "records"
  add_foreign_key "record_levels", "levels"
  add_foreign_key "record_levels", "records"
  add_foreign_key "record_questions", "questions"
  add_foreign_key "record_questions", "questions"
  add_foreign_key "record_questions", "records"
  add_foreign_key "records", "users"
end
