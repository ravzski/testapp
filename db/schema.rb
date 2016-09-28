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

ActiveRecord::Schema.define(version: 20160926121355) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string "name"
  end

  create_table "listing_photos", force: :cascade do |t|
    t.integer  "listing_id"
    t.string   "unique_photo_path"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
  end

  create_table "listings", force: :cascade do |t|
    t.string   "name"
    t.string   "category"
    t.text     "description"
    t.decimal  "price"
    t.string   "duration"
    t.decimal  "deposit"
    t.string   "lend_to"
    t.integer  "min_rent"
    t.integer  "max_rent"
    t.string   "min_rent_label"
    t.string   "max_rent_label"
    t.string   "deposit_requied_for"
    t.string   "status"
    t.string   "address"
    t.string   "zip"
    t.string   "city"
    t.string   "state"
    t.float    "lat"
    t.float    "lng"
    t.float    "random_lat"
    t.float    "random_lng"
    t.float    "distance_offset"
    t.integer  "user_id"
    t.integer  "primary_photo_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "street_number"
    t.string   "route"
    t.string   "locality"
    t.string   "administrative_area_level_1"
    t.string   "country"
    t.string   "postal_code"
    t.string   "currency"
    t.text     "drop_off_instructions"
    t.float    "offset_lat"
    t.float    "offset_lng"
    t.string   "formatted_address"
    t.string   "administrative_area_level_2"
  end

  create_table "products", force: :cascade do |t|
    t.string   "name"
    t.decimal  "price"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "category_id"
    t.index ["category_id"], name: "index_products_on_category_id", using: :btree
  end

  create_table "speeches", force: :cascade do |t|
    t.string   "title"
    t.text     "text"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "audio_file_name"
    t.string   "audio_content_type"
    t.integer  "audio_file_size"
    t.datetime "audio_updated_at"
    t.text     "summarized_text"
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "encrypted_password"
    t.string   "access_token"
    t.boolean  "is_active",                   default: true
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.boolean  "super_admin",                 default: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.string   "current_ip"
    t.string   "activation_token"
    t.datetime "activation_token_sent_at"
    t.string   "reset_account_token"
    t.datetime "reset_account_token_sent_at"
    t.string   "last_login_attemp_id"
    t.integer  "global_login_attemp_count"
    t.boolean  "is_locked",                   default: false
    t.string   "unique_photo_path"
    t.boolean  "is_fb_linked",                default: false
  end

  add_foreign_key "products", "categories"
end
