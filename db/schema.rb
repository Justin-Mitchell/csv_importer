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

ActiveRecord::Schema.define(version: 20150329172002) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "csv_imports", force: :cascade do |t|
    t.string   "source"
    t.boolean  "is_temp"
    t.string   "lead_type"
    t.string   "name"
    t.integer  "user_id",                               null: false
    t.string   "csv"
    t.integer  "total_records",         default: 0
    t.integer  "new_records_count",     default: 0
    t.integer  "updated_records_count", default: 0
    t.boolean  "csv_processed",         default: false
    t.string   "key"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "import_errors", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "field"
    t.text     "message"
    t.integer  "csv_import_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "import_errors", ["csv_import_id"], name: "index_import_errors_on_csv_import_id", using: :btree

  create_table "leads", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "kind"
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.string   "state"
    t.string   "zipcode"
    t.string   "source"
    t.string   "category"
    t.string   "company"
    t.string   "title"
    t.string   "phone_mobile"
    t.string   "phone_home"
    t.string   "phone_fax"
    t.string   "phone_work"
    t.date     "birthday"
    t.date     "purchase_date"
    t.float    "budget"
    t.float    "purchase_price"
    t.integer  "rating"
    t.float    "home_value"
    t.string   "entry_point"
    t.string   "alt_email"
    t.string   "status"
    t.string   "referred_by"
    t.string   "skype"
    t.string   "facebook"
    t.string   "gchat"
    t.string   "aol"
    t.string   "yahoo"
    t.string   "access"
    t.text     "comments"
    t.integer  "user_id"
    t.boolean  "flagged",        default: false
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  create_table "posts", force: :cascade do |t|
    t.string   "title"
    t.text     "content_md"
    t.text     "content_html"
    t.boolean  "draft",        default: false
    t.integer  "user_id"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "posts", ["user_id"], name: "index_posts_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.boolean  "admin",                  default: false, null: false
    t.boolean  "locked",                 default: false, null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "avatar"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "import_errors", "csv_imports"
end
