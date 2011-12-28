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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20111228020705) do

  create_table "answers", :force => true do |t|
    t.string   "user"
    t.string   "image"
    t.string   "profile_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "question_number"
    t.integer  "profile_code"
    t.boolean  "confirmed"
  end

  add_index "answers", ["image"], :name => "index_answers_on_image"
  add_index "answers", ["profile_name"], :name => "index_answers_on_profile"
  add_index "answers", ["question_number"], :name => "index_answers_on_question_number"
  add_index "answers", ["user"], :name => "index_answers_on_user"

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

end
