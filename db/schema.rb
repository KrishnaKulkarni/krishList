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

ActiveRecord::Schema.define(version: 20140501211950) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "ads", force: true do |t|
    t.string   "title",             null: false
    t.date     "start_date",        null: false
    t.string   "location"
    t.string   "region",            null: false
    t.integer  "price",             null: false
    t.integer  "subcat_id",         null: false
    t.integer  "submitter_id",      null: false
    t.text     "description"
    t.text     "options_data"
    t.integer  "flag_count"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "responses_count"
    t.string   "pic1_file_name"
    t.string   "pic1_content_type"
    t.integer  "pic1_file_size"
    t.datetime "pic1_updated_at"
  end

  add_index "ads", ["flag_count"], name: "index_ads_on_flag_count", using: :btree
  add_index "ads", ["price"], name: "index_ads_on_price", using: :btree
  add_index "ads", ["region"], name: "index_ads_on_region", using: :btree
  add_index "ads", ["start_date"], name: "index_ads_on_start_date", using: :btree
  add_index "ads", ["subcat_id"], name: "index_ads_on_subcat_id", using: :btree
  add_index "ads", ["submitter_id"], name: "index_ads_on_submitter_id", using: :btree
  add_index "ads", ["title"], name: "index_ads_on_title", using: :btree

  create_table "boolean_option_values", force: true do |t|
    t.boolean  "value",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", force: true do |t|
    t.string   "title",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "categories", ["title"], name: "index_categories_on_title", unique: true, using: :btree

  create_table "date_option_values", force: true do |t|
    t.date     "value",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "integer_option_values", force: true do |t|
    t.integer  "value",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "notifications", force: true do |t|
    t.integer  "notifiable_id",                   null: false
    t.string   "notifiable_type",                 null: false
    t.integer  "event_id",                        null: false
    t.boolean  "is_viewed",       default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "notifications", ["is_viewed"], name: "index_notifications_on_is_viewed", using: :btree
  add_index "notifications", ["notifiable_id"], name: "index_notifications_on_notifiable_id", using: :btree

  create_table "option_classes", force: true do |t|
    t.string   "title",                                 null: false
    t.integer  "option_classable_id",                   null: false
    t.string   "option_classable_type",                 null: false
    t.string   "input_type",                            null: false
    t.string   "value_type",                            null: false
    t.boolean  "is_mandatory",          default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "option_classes", ["option_classable_id"], name: "index_option_classes_on_option_classable_id", using: :btree
  add_index "option_classes", ["title"], name: "index_option_classes_on_title", using: :btree
  add_index "option_classes", ["value_type"], name: "index_option_classes_on_value_type", using: :btree

  create_table "options", force: true do |t|
    t.integer  "ad_id",             null: false
    t.integer  "option_class_id",   null: false
    t.integer  "option_value_id",   null: false
    t.string   "option_value_type", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "options", ["ad_id"], name: "index_options_on_ad_id", using: :btree
  add_index "options", ["option_class_id"], name: "index_options_on_option_class_id", using: :btree
  add_index "options", ["option_value_id"], name: "index_options_on_option_value_id", using: :btree

  create_table "pictures", force: true do |t|
    t.integer  "ad_id",              null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  add_index "pictures", ["ad_id"], name: "index_pictures_on_ad_id", using: :btree

  create_table "responses", force: true do |t|
    t.integer  "ad_id",         null: false
    t.integer  "respondent_id", null: false
    t.string   "title",         null: false
    t.text     "body",          null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "responses", ["ad_id"], name: "index_responses_on_ad_id", using: :btree
  add_index "responses", ["respondent_id"], name: "index_responses_on_respondent_id", using: :btree
  add_index "responses", ["title"], name: "index_responses_on_title", using: :btree

  create_table "string_option_values", force: true do |t|
    t.string   "value",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "subcats", force: true do |t|
    t.string   "title",                     null: false
    t.integer  "category_id",               null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "featured_option_class_id1"
    t.integer  "featured_option_class_id2"
  end

  add_index "subcats", ["category_id"], name: "index_subcats_on_category_id", using: :btree
  add_index "subcats", ["title"], name: "index_subcats_on_title", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                                     null: false
    t.string   "password_digest",                           null: false
    t.string   "session_token",                             null: false
    t.boolean  "is_admin",                  default: false
    t.boolean  "wants_forwarded_responses", default: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username",                                  null: false
    t.integer  "notifications_count"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["password_digest"], name: "index_users_on_password_digest", using: :btree
  add_index "users", ["session_token"], name: "index_users_on_session_token", using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

end
