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

ActiveRecord::Schema.define(version: 20131114184505) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "folders", force: true do |t|
    t.string   "name",                              null: false
    t.integer  "user_id",                           null: false
    t.integer  "parent_folder_ids", default: [],                 array: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_hash"
    t.boolean  "locked",            default: false
  end

  create_table "friendly_id_slugs", force: true do |t|
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

  create_table "friendships", force: true do |t|
    t.integer  "user_id",    null: false
    t.integer  "friend_id",  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "messages", force: true do |t|
    t.integer  "user_id",         null: false
    t.integer  "recipient_id",    null: false
    t.text     "body"
    t.datetime "read_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "conversation_id"
  end

  create_table "purchases", force: true do |t|
    t.integer  "user_id",     null: false
    t.integer  "upload_id",   null: false
    t.string   "upload_name", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "uploads", force: true do |t|
    t.integer  "user_id",                       null: false
    t.integer  "folder_id",                     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "original_name"
    t.string   "file"
    t.string   "password_hash"
    t.boolean  "locked",        default: false
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "password_salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
  end

  add_index "users", ["slug"], name: "index_users_on_slug", unique: true, using: :btree

  add_foreign_key "folders", "users", name: "folders_user_id_fk"

  add_foreign_key "friendships", "users", name: "friendships_friend_id_fk", column: "friend_id"
  add_foreign_key "friendships", "users", name: "friendships_user_id_fk"

  add_foreign_key "messages", "users", name: "messages_recipient_id_fk", column: "recipient_id"
  add_foreign_key "messages", "users", name: "messages_user_id_fk"

  add_foreign_key "purchases", "uploads", name: "purchases_upload_id_fk"
  add_foreign_key "purchases", "users", name: "purchases_user_id_fk"

  add_foreign_key "uploads", "folders", name: "uploads_folder_id_fk"
  add_foreign_key "uploads", "users", name: "uploads_user_id_fk"

end
