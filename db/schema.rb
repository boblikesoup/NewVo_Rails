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

ActiveRecord::Schema.define(version: 20140304165305) do

  create_table "activities", force: true do |t|
    t.integer  "trackable_id"
    t.string   "trackable_type"
    t.integer  "owner_id"
    t.string   "owner_type"
    t.string   "key"
    t.text     "parameters"
    t.integer  "recipient_id"
    t.string   "recipient_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "activities", ["owner_id", "owner_type"], name: "index_activities_on_owner_id_and_owner_type"
  add_index "activities", ["recipient_id", "recipient_type"], name: "index_activities_on_recipient_id_and_recipient_type"
  add_index "activities", ["trackable_id", "trackable_type"], name: "index_activities_on_trackable_id_and_trackable_type"

  create_table "comment_activities", force: true do |t|
    t.integer  "notified_user_id"
    t.integer  "other_user_id"
    t.integer  "comment_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "status",           default: 0
  end

  create_table "comments", force: true do |t|
    t.string   "body"
    t.integer  "post_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "status",     default: 0
  end

  create_table "following_activities", force: true do |t|
    t.integer  "notified_user_id"
    t.integer  "other_user_id"
    t.integer  "following_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "followed_type"
    t.integer  "status",           default: 0
  end

  create_table "followings", force: true do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "followings", ["followed_id"], name: "index_followings_on_followed_id"
  add_index "followings", ["follower_id", "followed_id"], name: "index_followings_on_follower_id_and_followed_id", unique: true
  add_index "followings", ["follower_id"], name: "index_followings_on_follower_id"

  create_table "friendship_activities", force: true do |t|
    t.integer  "notified_user_id"
    t.integer  "other_user_id"
    t.integer  "friendship_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "status",           default: 0
  end

  create_table "friendships", force: true do |t|
    t.integer  "user_id"
    t.integer  "friend_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "groups", force: true do |t|
    t.string   "title"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "member_ids"
    t.integer  "user_id"
  end

  create_table "groups_users", id: false, force: true do |t|
    t.integer "user_id",  null: false
    t.integer "group_id", null: false
  end

  add_index "groups_users", ["group_id", "user_id"], name: "index_groups_users_on_group_id_and_user_id"
  add_index "groups_users", ["user_id", "group_id"], name: "index_groups_users_on_user_id_and_group_id"

  create_table "photos", force: true do |t|
    t.integer  "post_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
  end

  create_table "posts", force: true do |t|
    t.string   "description"
    t.integer  "user_id"
    t.boolean  "has_single_picture", default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "global",             default: false
    t.integer  "status",             default: 0
    t.integer  "viewable_by",        default: 1
  end

  create_table "users", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "fb_uid"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "description"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "profile_pic"
    t.string   "newvo_token"
    t.string   "facebook_username"
    t.integer  "status",              default: 0
  end

  create_table "vote_activities", force: true do |t|
    t.integer  "notified_user_id"
    t.integer  "other_user_id"
    t.integer  "vote_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "status",           default: 0
  end

  create_table "votes", force: true do |t|
    t.integer  "votable_id"
    t.string   "votable_type"
    t.integer  "user_id"
    t.integer  "value",        default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "post_id"
    t.integer  "status",       default: 0
  end

end
