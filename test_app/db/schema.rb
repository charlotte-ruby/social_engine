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

ActiveRecord::Schema.define(:version => 20110521190117) do

  create_table "articles", :force => true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "friendings", :id => false, :force => true do |t|
    t.integer  "friendor_id"
    t.integer  "friendee_id"
    t.boolean  "confirmed",   :default => false
    t.boolean  "rejected",    :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "friendings", ["friendee_id"], :name => "index_friendings_on_friendee_id"
  add_index "friendings", ["friendor_id"], :name => "index_friendings_on_friendor_id"

  create_table "posts", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "article_id"
  end

  create_table "reviews", :force => true do |t|
    t.string   "reviewable_type"
    t.integer  "reviewable_id"
    t.integer  "user_id"
    t.string   "unauthenticated_name"
    t.string   "unauthenticated_email"
    t.string   "unauthenticated_website"
    t.text     "review"
    t.string   "pros"
    t.string   "cons"
    t.string   "ip_address"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email"
    t.string   "website"
  end

end
