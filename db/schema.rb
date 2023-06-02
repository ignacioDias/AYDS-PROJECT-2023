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

ActiveRecord::Schema[7.0].define(version: 2023_06_02_195651) do
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
    t.integer "level_id"
    t.index ["level_id"], name: "index_exams_on_level_id", unique: true
  end

  create_table "exams_profiles", id: false, force: :cascade do |t|
    t.integer "exams_id"
    t.integer "profiles_id"
    t.index "\"exam_id\", \"profile_id\"", name: "index_exams_profiles_on_exam_id_and_profile_id", unique: true
    t.index ["exams_id"], name: "index_exams_profiles_on_exams_id"
    t.index ["profiles_id"], name: "index_exams_profiles_on_profiles_id"
  end

  create_table "exams_records", id: false, force: :cascade do |t|
    t.integer "records_id"
    t.integer "exams_id"
    t.index "\"record_id\", \"exam_id\"", name: "index_records_exams_on_record_id_and_exam_id", unique: true
    t.index ["exams_id"], name: "index_exams_records_on_exams_id"
    t.index ["records_id"], name: "index_exams_records_on_records_id"
  end

  create_table "levels", force: :cascade do |t|
    t.string "name"
    t.integer "numLevel"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "category_id"
  end

  create_table "levels_records", id: false, force: :cascade do |t|
    t.integer "records_id"
    t.integer "levels_id"
    t.index "\"record_id\", \"level_id\"", name: "index_records_levels_on_record_id_and_level_id", unique: true
    t.index ["levels_id"], name: "index_levels_records_on_levels_id"
    t.index ["records_id"], name: "index_levels_records_on_records_id"
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

  create_table "questions_records", id: false, force: :cascade do |t|
    t.integer "records_id"
    t.integer "questions_id"
    t.index "\"record_id\", \"question_id\"", name: "index_records_questions_on_record_id_and_question_id", unique: true
    t.index ["questions_id"], name: "index_questions_records_on_questions_id"
    t.index ["records_id"], name: "index_questions_records_on_records_id"
  end

  create_table "rankings", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "records", force: :cascade do |t|
    t.integer "points"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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

  add_foreign_key "exams", "levels"
  add_foreign_key "levels", "categories"
  add_foreign_key "profiles", "users"
  add_foreign_key "questions", "exams"
  add_foreign_key "questions", "levels"
end
