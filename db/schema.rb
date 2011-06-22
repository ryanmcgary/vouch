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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110412225132) do

  create_table "authentications", :force => true do |t|
    t.integer   "user_id"
    t.string    "provider"
    t.string    "uid"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "recordings", :force => true do |t|
    t.string    "audio_file"
    t.string    "call_id"
    t.string    "synopsis"
    t.string    "transcription"
    t.boolean   "call_completed"
    t.integer   "remoteurl_id"
    t.integer   "user_id"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "remoteurls", :force => true do |t|
    t.integer   "site_id"
    t.string    "content"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.string    "permalink"
  end

  add_index "remoteurls", ["site_id"], :name => "index_remoteurls_on_site_id"

  create_table "reviews", :force => true do |t|
    t.integer   "remoteurl_id"
    t.string    "name"
    t.string    "mp3"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  add_index "reviews", ["remoteurl_id"], :name => "index_reviews_on_remoteurl_id"

  create_table "sites", :force => true do |t|
    t.string    "url"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.string    "permalink"
  end

  create_table "users", :force => true do |t|
    t.string    "email",                               :default => "", :null => false
    t.string    "encrypted_password",   :limit => 128, :default => "", :null => false
    t.string    "password_salt",                       :default => "", :null => false
    t.string    "reset_password_token"
    t.string    "remember_token"
    t.timestamp "remember_created_at"
    t.integer   "sign_in_count",                       :default => 0
    t.timestamp "current_sign_in_at"
    t.timestamp "last_sign_in_at"
    t.string    "current_sign_in_ip"
    t.string    "last_sign_in_ip"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.string    "profile_pic"
    t.string    "phone_number"
    t.string    "company"
    t.string    "title"
    t.string    "description"
    t.string    "location"
    t.string    "full_name"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
