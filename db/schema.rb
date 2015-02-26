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

ActiveRecord::Schema.define(version: 20150225203330) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "alerts", force: true do |t|
    t.integer  "project_id"
    t.integer  "staff_id"
    t.string   "status",        limit: 20
    t.text     "message"
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "order_item_id"
  end

  add_index "alerts", ["end_date"], name: "index_alerts_on_end_date", using: :btree
  add_index "alerts", ["order_item_id"], name: "index_order_item_id", using: :btree
  add_index "alerts", ["start_date"], name: "index_alerts_on_start_date", using: :btree

  create_table "approvals", force: true do |t|
    t.integer  "staff_id"
    t.integer  "project_id"
    t.boolean  "approved"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "reason"
  end

  add_index "approvals", ["project_id"], name: "index_approvals_on_project_id", using: :btree
  add_index "approvals", ["staff_id"], name: "index_approvals_on_staff_id", using: :btree

  create_table "carts", force: true do |t|
    t.integer  "count"
    t.integer  "staff_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "carts", ["staff_id"], name: "index_carts_on_staff_id", using: :btree

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

  create_table "delayed_jobs", force: true do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "logs", force: true do |t|
    t.integer  "staff_id",   null: false
    t.integer  "level"
    t.text     "message"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "logs", ["staff_id"], name: "index_logs_on_staff_id", using: :btree

  create_table "notifications", force: true do |t|
    t.text     "text"
    t.text     "ago"
    t.integer  "staff_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "notifications", ["staff_id"], name: "index_notifications_on_staff_id", using: :btree

  create_table "order_items", force: true do |t|
    t.integer  "order_id"
    t.integer  "cloud_id"
    t.integer  "product_id"
    t.integer  "service_id"
    t.integer  "provision_status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
    t.integer  "project_id"
    t.string   "host"
    t.integer  "port"
    t.integer  "miq_id"
    t.inet     "public_ip"
    t.string   "hostname"
    t.uuid     "uuid",                                               default: "uuid_generate_v4()"
    t.decimal  "setup_price",               precision: 10, scale: 4, default: 0.0
    t.decimal  "hourly_price",              precision: 10, scale: 4, default: 0.0
    t.decimal  "monthly_price",             precision: 10, scale: 4, default: 0.0
    t.json     "payload_to_miq"
    t.json     "payload_reply_from_miq"
    t.json     "payload_response_from_miq"
    t.integer  "latest_alert_id"
    t.string   "url"
    t.string   "instance_name"
    t.string   "instance_id"
    t.string   "username"
    t.string   "password"
    t.string   "status_msg"
    t.inet     "private_ip"
  end

  add_index "order_items", ["cloud_id"], name: "index_order_items_on_cloud_id", using: :btree
  add_index "order_items", ["deleted_at"], name: "index_order_items_on_deleted_at", using: :btree
  add_index "order_items", ["hostname"], name: "index_order_items_on_hostname", using: :btree
  add_index "order_items", ["miq_id"], name: "index_order_items_on_miq_id", using: :btree
  add_index "order_items", ["order_id"], name: "index_order_items_on_order_id", using: :btree
  add_index "order_items", ["port", "host"], name: "index_order_items_on_port_and_host", using: :btree
  add_index "order_items", ["product_id"], name: "index_order_items_on_product_id", using: :btree
  add_index "order_items", ["service_id"], name: "index_order_items_on_service_id", using: :btree

  create_table "orders", force: true do |t|
    t.integer  "staff_id",                      null: false
    t.text     "engine_response"
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.json     "options"
    t.datetime "deleted_at"
    t.float    "total",           default: 0.0
  end

  add_index "orders", ["deleted_at"], name: "index_orders_on_deleted_at", using: :btree
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

  create_table "product_answers", force: true do |t|
    t.integer  "product_id",               null: false
    t.integer  "product_type_question_id", null: false
    t.text     "answer"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "product_answers", ["product_id"], name: "index_product_answers_on_product_id", using: :btree
  add_index "product_answers", ["product_type_question_id"], name: "index_product_answers_on_product_type_question_id", using: :btree

  create_table "product_type_questions", force: true do |t|
    t.integer  "product_type_id",                 null: false
    t.text     "label"
    t.string   "field_type"
    t.string   "placeholder"
    t.text     "help"
    t.json     "options"
    t.text     "default"
    t.boolean  "required",        default: false
    t.integer  "load_order"
    t.string   "manageiq_key"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "product_type_questions", ["product_type_id", "load_order"], name: "question_order_idx", using: :btree

  create_table "product_types", force: true do |t|
    t.string   "name"
    t.text     "description"
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
    t.boolean  "active"
    t.string   "img"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.json     "options"
    t.datetime "deleted_at"
    t.integer  "product_type_id"
    t.decimal  "setup_price",                    precision: 10, scale: 4, default: 0.0
    t.decimal  "hourly_price",                   precision: 10, scale: 4, default: 0.0
    t.decimal  "monthly_price",                  precision: 10, scale: 4, default: 0.0
  end

  add_index "products", ["cloud_id"], name: "index_products_on_cloud_id", using: :btree
  add_index "products", ["deleted_at"], name: "index_products_on_deleted_at", using: :btree
  add_index "products", ["product_type_id"], name: "index_products_on_product_type_id", using: :btree

  create_table "project_answers", force: true do |t|
    t.integer  "project_id"
    t.integer  "project_question_id"
    t.text     "answer"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "project_answers", ["project_id"], name: "index_project_answers_on_project_id", using: :btree
  add_index "project_answers", ["project_question_id"], name: "index_project_answers_on_project_question_id", using: :btree

  create_table "project_details", force: true do |t|
    t.string  "requestor_name"
    t.date    "requestor_date"
    t.string  "team_name"
    t.integer "charge_number"
    t.float   "nte_budget"
    t.string  "project_owner"
    t.string  "sr_associate"
    t.string  "principal"
    t.date    "estimated_termination_date"
    t.string  "data_type"
    t.string  "others"
    t.integer "project_id"
  end

  add_index "project_details", ["project_id"], name: "index_project_details_on_project_id", using: :btree

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
    t.string   "img"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "deleted_at"
    t.decimal  "spent",                  precision: 12, scale: 2, default: 0.0
    t.integer  "status",                                          default: 0
    t.integer  "approval",                                        default: 0
  end

  add_index "projects", ["deleted_at"], name: "index_projects_on_deleted_at", using: :btree

  create_table "setting_fields", force: true do |t|
    t.string   "label"
    t.integer  "field_type",             default: 0
    t.string   "help_text"
    t.json     "options"
    t.text     "value"
    t.string   "required",     limit: 1
    t.integer  "load_order"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "setting_id"
    t.string   "env_var_name"
    t.boolean  "disabled",               default: false
    t.string   "hid",                                    null: false
    t.boolean  "secret",                 default: false, null: false
  end

  add_index "setting_fields", ["setting_id", "hid"], name: "index_setting_fields_on_setting_id_and_hid", unique: true, using: :btree
  add_index "setting_fields", ["setting_id"], name: "index_setting_fields_on_setting_id", using: :btree

  create_table "settings", force: true do |t|
    t.string "name"
    t.string "hid",  null: false
  end

  add_index "settings", ["hid"], name: "index_settings_on_hid", unique: true, using: :btree

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
    t.string   "authentication_token"
  end

  add_index "staff", ["authentication_token"], name: "index_staff_on_authentication_token", unique: true, using: :btree
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
