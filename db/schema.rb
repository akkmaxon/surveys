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

ActiveRecord::Schema.define(version: 20160919095653) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string   "login",                  default: "", null: false
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["login"], name: "index_admins_on_login", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree
  end

  create_table "companies", force: :cascade do |t|
    t.string   "name",       default: ""
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "coordinators", force: :cascade do |t|
    t.string   "login",               default: "", null: false
    t.string   "encrypted_password",  default: "", null: false
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",       default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.index ["login"], name: "index_coordinators_on_login", unique: true, using: :btree
  end

  create_table "infos", force: :cascade do |t|
    t.string   "gender",           default: ""
    t.string   "experience",       default: ""
    t.string   "age",              default: ""
    t.string   "workplace_number", default: ""
    t.string   "work_position",    default: ""
    t.integer  "user_id"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.string   "company",          default: ""
    t.index ["user_id"], name: "index_infos_on_user_id", using: :btree
  end

  create_table "left_statements", force: :cascade do |t|
    t.string   "title",       default: ""
    t.text     "text",        default: ""
    t.integer  "question_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.index ["question_id"], name: "index_left_statements_on_question_id", using: :btree
  end

  create_table "questions", force: :cascade do |t|
    t.string   "audience",        default: ""
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "number"
    t.string   "opinion_subject"
    t.text     "sentence",        default: ""
    t.string   "criterion"
    t.string   "criterion_type",  default: ""
  end

  create_table "responses", force: :cascade do |t|
    t.string   "answer",          default: ""
    t.integer  "survey_id"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "question_number"
    t.index ["survey_id"], name: "index_responses_on_survey_id", using: :btree
  end

  create_table "right_statements", force: :cascade do |t|
    t.string   "title",       default: ""
    t.text     "text",        default: ""
    t.integer  "question_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.index ["question_id"], name: "index_right_statements_on_question_id", using: :btree
  end

  create_table "surveys", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.string   "user_agreement", default: ""
    t.string   "user_email"
    t.boolean  "completed",      default: false
    t.string   "audience",       default: "management"
    t.index ["user_id"], name: "index_surveys_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "login",               default: "", null: false
    t.string   "encrypted_password",  default: "", null: false
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",       default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.string   "decrypted_password"
    t.index ["login"], name: "index_users_on_login", unique: true, using: :btree
  end

  add_foreign_key "infos", "users"
  add_foreign_key "left_statements", "questions"
  add_foreign_key "responses", "surveys"
  add_foreign_key "right_statements", "questions"
  add_foreign_key "surveys", "users"
end
