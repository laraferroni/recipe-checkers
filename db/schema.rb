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

ActiveRecord::Schema.define(version: 20160131010432) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "assets", force: true do |t|
    t.string   "type"
    t.string   "attachment_file_name"
    t.string   "attachment_content_type"
    t.string   "attachment_file_size"
    t.string   "orientation"
    t.datetime "attachment_updated_at"
    t.integer  "assetable_id"
    t.string   "assetable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "assets", ["assetable_id", "assetable_type"], name: "index_assets_on_assetable_id_and_assetable_type", using: :btree

  create_table "author_blacklists", force: true do |t|
    t.integer  "user_id"
    t.integer  "tester_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "author_whitelists", force: true do |t|
    t.integer  "user_id"
    t.integer  "tester_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "projects", force: true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "complete",      default: false
    t.text     "terms"
    t.datetime "test_deadline"
  end

  create_table "recipe_notes", force: true do |t|
    t.integer  "user_id"
    t.integer  "recipe_revision_id"
    t.text     "notes"
    t.integer  "start_char"
    t.integer  "end_char"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "line_id"
    t.boolean  "hide",               default: false
  end

  create_table "recipe_ratings", force: true do |t|
    t.integer  "user_id"
    t.integer  "recipe_revision_id"
    t.integer  "overall_satisfaction", default: 0
    t.integer  "would_make_again",     default: 0
    t.string   "servings_made"
    t.string   "time_to_make"
    t.text     "overall_notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "reviewer_rating",      default: 0
  end

  create_table "recipe_revisions", force: true do |t|
    t.integer  "recipe_id"
    t.integer  "version_number"
    t.text     "recipe_servings"
    t.text     "recipe_body"
    t.text     "notes_from_author"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "number_of_testers", default: 3
    t.boolean  "ready_to_test",     default: false
    t.text     "private_notes"
  end

  create_table "recipes", force: true do |t|
    t.integer  "project_id"
    t.integer  "user_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "recipe_servings"
    t.integer  "number_of_testers", default: 3
    t.boolean  "complete",          default: false
    t.datetime "test_deadline"
  end

  create_table "tester_recipes", force: true do |t|
    t.integer  "user_id"
    t.integer  "recipe_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "approved",   default: false
  end

  create_table "user_authentications", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "provider"
  end

  create_table "user_preferences", force: true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.boolean  "author"
    t.boolean  "tester"
    t.datetime "created_at"
    t.datetime "updated_at"
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
    t.text     "tester_bio"
    t.text     "author_bio"
    t.string   "website"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
