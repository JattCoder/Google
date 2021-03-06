# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 6) do

  create_table "accounts", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
  end

  create_table "businesses", force: :cascade do |t|
    t.integer "account_id"
    t.string "name"
    t.string "address"
    t.string "biztype"
    t.float "latitude"
    t.float "longitude"
  end

  create_table "chatbans", force: :cascade do |t|
    t.integer "account_id"
    t.integer "chat_id"
  end

  create_table "chats", force: :cascade do |t|
    t.integer "account_id"
    t.string "location"
    t.string "message"
    t.string "title"
    t.integer "admin"
  end

  create_table "gmaps", force: :cascade do |t|
    t.integer "account_id"
    t.float "latitude"
    t.float "longitude"
  end

  create_table "items", force: :cascade do |t|
    t.integer "business_id"
    t.string "name"
    t.float "cost"
    t.string "discription"
    t.string "image"
  end

end
