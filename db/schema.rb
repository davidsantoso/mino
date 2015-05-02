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

ActiveRecord::Schema.define(version: 20150502005601) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "clients", force: :cascade do |t|
    t.integer  "user_id",                                null: false
    t.string   "token",      limit: 255,                 null: false
    t.boolean  "verified",               default: false
    t.boolean  "enabled",                default: false
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  add_index "clients", ["token"], name: "index_clients_on_token", unique: true, using: :btree

  create_table "secrets", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.string   "name"
    t.string   "url"
    t.string   "username",   null: false
    t.string   "password",   null: false
    t.text     "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "secrets", ["user_id"], name: "index_secrets_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                 limit: 255,                 null: false
    t.boolean  "verified",                          default: false
    t.text     "public_key",                                        null: false
    t.text     "encrypted_private_key",                             null: false
    t.string   "nonce",                                             null: false
    t.string   "salt",                                              null: false
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

  create_table "verifications", force: :cascade do |t|
    t.string   "token",                           null: false
    t.integer  "verifiable_id"
    t.string   "verifiable_type"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.boolean  "expired",         default: false
  end

  add_index "verifications", ["verifiable_type", "verifiable_id"], name: "index_verifications_on_verifiable_type_and_verifiable_id", using: :btree

end
