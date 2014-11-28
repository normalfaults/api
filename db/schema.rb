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

ActiveRecord::Schema.define(version: 20141125222152) do

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

  add_index "alerts", ["project_id"], name: "index_alerts_on_project_id", using: :btree
  add_index "alerts", ["staff_id"], name: "index_alerts_on_staff_id", using: :btree

  create_table "approvals", force: true do |t|
    t.integer  "staff_id"
    t.integer  "project_id"
    t.boolean  "approved"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "approvals", ["project_id"], name: "index_approvals_on_project_id", using: :btree
  add_index "approvals", ["staff_id"], name: "index_approvals_on_staff_id", using: :btree

  create_table "chargebacks", force: true do |t|
    t.integer  "product_id"
    t.integer  "cloud_id"
    t.decimal  "hourly_price", precision: 8, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  add_index "chargebacks", ["cloud_id"], name: "index_chargebacks_on_cloud_id", using: :btree
  add_index "chargebacks", ["deleted_at"], name: "index_chargebacks_on_deleted_at", using: :btree
  add_index "chargebacks", ["product_id"], name: "index_chargebacks_on_product_id", using: :btree

  create_table "clouds", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "extra"
    t.datetime "deleted_at"
  end

  add_index "clouds", ["deleted_at"], name: "index_clouds_on_deleted_at", using: :btree

  create_table "logs", force: true do |t|
    t.integer  "staff_id",   null: false
    t.integer  "level"
    t.text     "message"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "logs", ["staff_id"], name: "index_logs_on_staff_id", using: :btree

  create_table "orders", force: true do |t|
    t.integer  "product_id",                  null: false
    t.integer  "project_id",                  null: false
    t.integer  "staff_id",                    null: false
    t.integer  "cloud_id",                    null: false
    t.text     "engine_response"
    t.string   "provision_status", limit: 50
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.json     "options"
    t.datetime "deleted_at"
  end

  add_index "orders", ["cloud_id"], name: "index_orders_on_cloud_id", using: :btree
  add_index "orders", ["deleted_at"], name: "index_orders_on_deleted_at", using: :btree
  add_index "orders", ["product_id"], name: "index_orders_on_product_id", using: :btree
  add_index "orders", ["project_id"], name: "index_orders_on_project_id", using: :btree
  add_index "orders", ["staff_id"], name: "index_orders_on_staff_id", using: :btree

  create_table "organizations", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "img"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  add_index "organizations", ["deleted_at"], name: "index_organizations_on_deleted_at", using: :btree

  create_table "products", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "service_type_id"
    t.integer  "service_catalog_id"
    t.integer  "cloud_id"
    t.string   "chef_role",          limit: 100
    t.boolean  "active"
    t.string   "img"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.json     "options"
    t.datetime "deleted_at"
  end

  add_index "products", ["cloud_id"], name: "index_products_on_cloud_id", using: :btree
  add_index "products", ["deleted_at"], name: "index_products_on_deleted_at", using: :btree

  create_table "project_answers", force: true do |t|
    t.integer  "project_id"
    t.integer  "project_question_id"
    t.text     "answer"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "project_answers", ["project_id"], name: "index_project_answers_on_project_id", using: :btree
  add_index "project_answers", ["project_question_id"], name: "index_project_answers_on_project_question_id", using: :btree

  create_table "project_questions", force: true do |t|
    t.string   "question"
    t.string   "help_text"
    t.boolean  "required"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
    t.integer  "load_order"
    t.json     "options"
    t.integer  "field_type", default: 0
  end

  add_index "project_questions", ["deleted_at"], name: "index_project_questions_on_deleted_at", using: :btree

  create_table "projects", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "cc",          limit: 10
    t.float    "budget"
    t.string   "staff_id"
    t.date     "start_date"
    t.date     "end_date"
    t.boolean  "approved"
    t.string   "img"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  add_index "projects", ["deleted_at"], name: "index_projects_on_deleted_at", using: :btree

  create_table "settings", force: true do |t|
    t.string   "name"
    t.text     "value"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  add_index "settings", ["deleted_at"], name: "index_settings_on_deleted_at", using: :btree
  add_index "settings", ["name"], name: "index_settings_on_name", unique: true, using: :btree

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
    t.datetime "deleted_at"
  end

  add_index "staff", ["deleted_at"], name: "index_staff_on_deleted_at", using: :btree
  add_index "staff", ["email"], name: "index_staff_on_email", unique: true, using: :btree
  add_index "staff", ["reset_password_token"], name: "index_staff_on_reset_password_token", unique: true, using: :btree

  create_table "staff_projects", force: true do |t|
    t.integer "staff_id"
    t.integer "project_id"
  end

  add_index "staff_projects", ["project_id"], name: "index_staff_projects_on_project_id", using: :btree
  add_index "staff_projects", ["staff_id", "project_id"], name: "index_staff_projects_on_staff_id_and_project_id", unique: true, using: :btree

  create_table "user_setting_options", force: true do |t|
    t.string   "label"
    t.string   "field_type", limit: 100
    t.string   "help_text"
    t.text     "options"
    t.boolean  "required",               default: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  add_index "user_setting_options", ["deleted_at"], name: "index_user_setting_options_on_deleted_at", using: :btree
  add_index "user_setting_options", ["label"], name: "index_user_setting_options_on_label", unique: true, using: :btree

  create_table "user_settings", force: true do |t|
    t.integer  "staff_id"
    t.string   "name"
    t.text     "value"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
  end

  add_index "user_settings", ["deleted_at"], name: "index_user_settings_on_deleted_at", using: :btree
  add_index "user_settings", ["staff_id", "name"], name: "index_user_settings_on_staff_id_and_name", unique: true, using: :btree

end
