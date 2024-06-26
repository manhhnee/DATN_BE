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

ActiveRecord::Schema[7.1].define(version: 2024_06_22_041626) do
  create_table "active_storage_attachments", charset: "utf8mb3", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", charset: "utf8mb3", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", charset: "utf8mb3", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "attendance_types", charset: "utf8mb3", force: :cascade do |t|
    t.string "type_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "attendances", charset: "utf8mb3", force: :cascade do |t|
    t.date "date"
    t.bigint "user_id"
    t.bigint "attendance_type_id"
    t.timestamp "created_at"
    t.time "time_check"
    t.index ["attendance_type_id"], name: "fk_rails_65c18d8303"
    t.index ["user_id"], name: "fk_rails_77ad02f5c5"
  end

  create_table "departments", charset: "utf8mb3", force: :cascade do |t|
    t.string "department_name"
    t.timestamp "created_at"
  end

  create_table "face_data", charset: "utf8mb3", force: :cascade do |t|
    t.bigint "user_id"
    t.timestamp "created_at"
    t.index ["user_id"], name: "fk_rails_25b1d77efc"
  end

  create_table "holidays", charset: "utf8mb3", force: :cascade do |t|
    t.date "holiday_date"
    t.string "description"
    t.timestamp "created_at"
  end

  create_table "notes", charset: "utf8mb3", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "label"
    t.date "day"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_notes_on_user_id"
  end

  create_table "reports", charset: "utf8mb3", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.date "date", null: false
    t.bigint "attendance_type_id", null: false
    t.time "time_check"
    t.boolean "approved", default: false
    t.string "reason"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["attendance_type_id"], name: "index_reports_on_attendance_type_id"
    t.index ["user_id"], name: "index_reports_on_user_id"
  end

  create_table "salaries", charset: "utf8mb3", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.date "date", null: false
    t.decimal "total_salary", precision: 10, scale: 2, default: "0.0"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_salaries_on_user_id"
  end

  create_table "users", charset: "utf8mb3", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "phone_number"
    t.date "date_of_birth"
    t.string "email"
    t.string "password_digest"
    t.integer "role"
    t.bigint "department_id"
    t.datetime "created_at", null: false
    t.string "avatar"
    t.decimal "basic_salary", precision: 10, scale: 2
    t.index ["department_id"], name: "fk_rails_f29bf9cdf2"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "attendances", "attendance_types"
  add_foreign_key "attendances", "users"
  add_foreign_key "face_data", "users"
  add_foreign_key "notes", "users"
  add_foreign_key "reports", "attendance_types"
  add_foreign_key "reports", "users"
  add_foreign_key "salaries", "users"
  add_foreign_key "users", "departments"
end
