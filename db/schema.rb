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

ActiveRecord::Schema.define(version: 20131208114826) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "folders", force: true do |t|
    t.string   "name",                              null: false
    t.integer  "user_id",                           null: false
    t.integer  "parent_folder_ids", default: [],                 array: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_hash"
    t.boolean  "locked",            default: false
  end

  add_index "folders", ["user_id"], name: "index_folders_on_user_id", using: :btree

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

  add_index "friendships", ["user_id", "friend_id"], name: "index_friendships_on_user_id_and_friend_id", unique: true, using: :btree

  create_table "messages", force: true do |t|
    t.integer  "user_id",                              null: false
    t.integer  "recipient_id",                         null: false
    t.text     "body"
    t.datetime "read_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "conversation_id"
    t.boolean  "deleted_by_user",      default: false
    t.boolean  "deleted_by_recipient", default: false
  end

  add_index "messages", ["conversation_id"], name: "index_messages_on_conversation_id", using: :btree
  add_index "messages", ["recipient_id", "read_at", "conversation_id"], name: "index_messages_on_recipient_id_and_read_at_and_conversation_id", using: :btree
  add_index "messages", ["user_id"], name: "index_messages_on_user_id", using: :btree

  create_table "permissions", force: true do |t|
    t.integer  "owner_id",   null: false
    t.integer  "user_id"
    t.integer  "item_id",    null: false
    t.string   "item_type",  null: false
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
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
    t.integer  "size",                          null: false
  end

  add_index "uploads", ["folder_id"], name: "index_uploads_on_folder_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email",                            default: "",    null: false
    t.string   "encrypted_password",               default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                    default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "password_salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
    t.boolean  "is_admin",                         default: false, null: false
    t.integer  "space_limit",            limit: 8,                 null: false
    t.integer  "used_space",             limit: 8, default: 0,     null: false
    t.boolean  "is_company",                       default: false, null: false
    t.hstore   "company_data"
  end

  add_index "users", ["is_company"], name: "index_users_on_is_company", using: :btree
  add_index "users", ["slug"], name: "index_users_on_slug", unique: true, using: :btree

  add_foreign_key "folders", "users", name: "folders_user_id_fk"

  add_foreign_key "friendships", "users", name: "friendships_friend_id_fk", column: "friend_id"
  add_foreign_key "friendships", "users", name: "friendships_user_id_fk"

  add_foreign_key "messages", "users", name: "messages_recipient_id_fk", column: "recipient_id"
  add_foreign_key "messages", "users", name: "messages_user_id_fk"

  add_foreign_key "permissions", "users", name: "permissions_owner_id_fk", column: "owner_id"
  add_foreign_key "permissions", "users", name: "permissions_user_id_fk"

  add_foreign_key "purchases", "uploads", name: "purchases_upload_id_fk"
  add_foreign_key "purchases", "users", name: "purchases_user_id_fk"

  add_foreign_key "uploads", "folders", name: "uploads_folder_id_fk"
  add_foreign_key "uploads", "users", name: "uploads_user_id_fk"

end
