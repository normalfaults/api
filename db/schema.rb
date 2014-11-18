# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20141117155651) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "alerts", force: true do |t|
    t.integer  "project_id"
    t.integer  "app_id"
    t.integer  "staff_id"
    t.string   "status",     limit: 20
    t.string   "message"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "approvals", force: true do |t|
    t.integer  "staff_id"
    t.integer  "project_id"
    t.string   "approved",   limit: 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "chargebacks", force: true do |t|
    t.integer  "product_id"
    t.integer  "cloud_id"
    t.float    "hourly_price"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "clouds", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "log", force: true do |t|
    t.integer  "staff_id"
    t.integer  "level"
    t.text     "message"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "orders", force: true do |t|
    t.integer  "product_id"
    t.integer  "project_id"
    t.integer  "staff_id"
    t.integer  "cloud_id"
    t.text     "options"
    t.text     "engine_response"
    t.string   "provision_status", limit: 50
    t.integer  "active",           limit: 2
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "organizations", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "img"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "products", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "service_type_id"
    t.integer  "service_catalog_id"
    t.integer  "cloud_id"
    t.string   "chef_role",          limit: 100
    t.text     "options"
    t.integer  "active",             limit: 2
    t.string   "img"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "project_questions", force: true do |t|
    t.string   "question"
    t.string   "field_type", limit: 100
    t.string   "help_text"
    t.text     "options"
    t.string   "required",   limit: 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "project_staff", force: true do |t|
    t.integer  "project_id"
    t.integer  "staff_id"
    t.integer  "role_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "projects", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "cc",          limit: 10
    t.float    "budget"
    t.string   "staff_id"
    t.date     "start_date"
    t.date     "end_date"
    t.string   "approved",    limit: 1
    t.string   "img"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", force: true do |t|
    t.string   "name"
    t.integer  "access"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "settings", force: true do |t|
    t.string   "name"
    t.text     "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "staff", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "phone",                  limit: 30
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "encrypted_password",                default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                     default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.integer  "role",                              default: 0
  end

  add_index "staff", ["email"], name: "index_staff_on_email", unique: true, using: :btree
  add_index "staff", ["reset_password_token"], name: "index_staff_on_reset_password_token", unique: true, using: :btree

  create_table "staff_projects", force: true do |t|
    t.integer "staff_id"
    t.integer "project_id"
  end

  add_index "staff_projects", ["project_id"], name: "index_staff_projects_on_project_id", using: :btree
  add_index "staff_projects", ["staff_id", "project_id"], name: "index_staff_projects_on_staff_id_and_project_id", unique: true, using: :btree

end
