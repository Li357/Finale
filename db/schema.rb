# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_12_20_172126) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", primary_key: "user_id", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "courses", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "department_id", null: false
    t.index ["department_id"], name: "index_courses_on_department_id"
  end

  create_table "department_assignments", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "teacher_id", null: false
    t.bigint "department_id", null: false
    t.index ["department_id"], name: "index_department_assignments_on_department_id"
    t.index ["teacher_id"], name: "index_department_assignments_on_teacher_id"
  end

  create_table "departments", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "finals", force: :cascade do |t|
    t.integer "mod"
    t.integer "capacity"
    t.string "room"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "course_id", null: false
    t.index ["course_id"], name: "index_finals_on_course_id"
  end

  create_table "roles", force: :cascade do |t|
    t.integer "role_type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_roles_on_user_id"
  end

  create_table "student_course_registrations", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "student_id", null: false
    t.bigint "course_id", null: false
    t.index ["course_id"], name: "index_student_course_registrations_on_course_id"
    t.index ["student_id"], name: "index_student_course_registrations_on_student_id"
  end

  create_table "student_final_signups", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "student_id", null: false
    t.bigint "final_id", null: false
    t.index ["final_id"], name: "index_student_final_signups_on_final_id"
    t.index ["student_id", "final_id"], name: "index_student_final_signups_on_student_id_and_final_id", unique: true
    t.index ["student_id"], name: "index_student_final_signups_on_student_id"
  end

  create_table "students", primary_key: "user_id", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "teacher_course_registrations", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "teacher_id", null: false
    t.bigint "course_id", null: false
    t.index ["course_id"], name: "index_teacher_course_registrations_on_course_id"
    t.index ["teacher_id"], name: "index_teacher_course_registrations_on_teacher_id"
  end

  create_table "teacher_final_assignments", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "teacher_id", null: false
    t.bigint "final_id", null: false
    t.index ["final_id"], name: "index_teacher_final_assignments_on_final_id"
    t.index ["teacher_id"], name: "index_teacher_final_assignments_on_teacher_id"
  end

  create_table "teachers", primary_key: "user_id", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "first_name"
    t.string "middle_name"
    t.string "last_name"
    t.string "suffix"
    t.string "profile_photo"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "courses", "departments"
  add_foreign_key "department_assignments", "departments"
  add_foreign_key "department_assignments", "teachers", primary_key: "user_id"
  add_foreign_key "finals", "courses"
  add_foreign_key "roles", "users"
  add_foreign_key "student_course_registrations", "courses"
  add_foreign_key "student_course_registrations", "students", primary_key: "user_id"
  add_foreign_key "student_final_signups", "finals"
  add_foreign_key "student_final_signups", "students", primary_key: "user_id"
  add_foreign_key "teacher_course_registrations", "courses"
  add_foreign_key "teacher_course_registrations", "teachers", primary_key: "user_id"
  add_foreign_key "teacher_final_assignments", "finals"
  add_foreign_key "teacher_final_assignments", "teachers", primary_key: "user_id"
end
