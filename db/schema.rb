# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_06_03_080957) do
  create_table "comments", force: :cascade do |t|
    t.string "name"
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "nested_post_id"
    t.index ["nested_post_id"], name: "index_comments_on_nested_post_id"
  end

  create_table "likes", force: :cascade do |t|
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "nested_post_id"
    t.index ["nested_post_id"], name: "index_likes_on_nested_post_id"
    t.index ["user_id"], name: "index_likes_on_user_id"
  end

  create_table "nested_posts", force: :cascade do |t|
    t.string "title"
    t.text "body"
    t.integer "post_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.index ["post_id"], name: "index_nested_posts_on_post_id"
  end

  create_table "posts", force: :cascade do |t|
    t.string "title"
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.integer "topic"
    t.integer "integer_field1"
    t.integer "integer_field2"
    t.integer "integer_field3"
    t.string "string_field1"
    t.string "string_field2"
    t.string "string_field3"
    t.text "multiline_text1"
    t.text "multiline_text2"
    t.text "multiline_text3"
    t.boolean "boolean_field1"
    t.boolean "boolean_field2"
    t.boolean "boolean_field3"
    t.date "date_field1"
    t.date "date_field2"
    t.date "date_field3"
    t.string "boolean_field1_text"
    t.string "boolean_field2_text"
    t.string "boolean_field3_text"
  end

  create_table "taggables", force: :cascade do |t|
    t.integer "nested_post_id", null: false
    t.integer "tag_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["nested_post_id"], name: "index_taggables_on_nested_post_id"
    t.index ["tag_id"], name: "index_taggables_on_tag_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "role"
    t.boolean "blocked"
    t.integer "user_id"
    t.string "theme"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "comments", "nested_posts"
  add_foreign_key "likes", "nested_posts"
  add_foreign_key "likes", "users"
  add_foreign_key "nested_posts", "posts"
  add_foreign_key "taggables", "nested_posts"
  add_foreign_key "taggables", "tags"
end
