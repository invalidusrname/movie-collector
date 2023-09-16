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

ActiveRecord::Schema[7.0].define(version: 2023_09_16_153918) do
  create_table "box_office_films", force: :cascade do |t|
    t.string "title"
    t.text "url"
    t.float "amount"
    t.text "ticket_url"
    t.integer "position"
    t.date "release_date"
    t.integer "duration"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
  end

  create_table "genres", force: :cascade do |t|
    t.string "name"
  end

  create_table "movies", force: :cascade do |t|
    t.string "title"
    t.string "format"
    t.string "asin"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.text "image"
    t.text "image_link"
    t.text "thumbnail"
    t.date "release_date"
    t.string "upc"
    t.integer "genre_id"
    t.index ["genre_id"], name: "index_movies_on_genre_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.string "session_id", null: false
    t.text "data"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.index ["session_id"], name: "index_sessions_on_session_id"
    t.index ["updated_at"], name: "index_sessions_on_updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "encrypted_password", limit: 128
    t.string "salt", limit: 128
    t.string "token", limit: 128
    t.datetime "token_expires_at", precision: nil
    t.boolean "email_confirmed", default: false, null: false
    t.boolean "admin"
    t.string "twitter_id"
    t.string "login"
    t.string "access_token"
    t.string "access_secret"
    t.string "profile_image_url"
    t.string "remember_token"
    t.datetime "remember_token_expires_at", precision: nil
    t.string "confirmation_token"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email"
    t.index ["id", "token"], name: "index_users_on_id_and_token"
    t.index ["remember_token"], name: "index_users_on_remember_token", unique: true
    t.index ["token"], name: "index_users_on_token"
  end

  create_table "users_movies", force: :cascade do |t|
    t.integer "user_id"
    t.integer "movie_id"
    t.integer "rating"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.boolean "private"
    t.integer "borrower_id"
    t.index ["borrower_id"], name: "index_users_movies_on_borrower_id"
    t.index ["movie_id"], name: "index_users_movies_on_movie_id"
    t.index ["user_id"], name: "index_users_movies_on_user_id"
  end

end
