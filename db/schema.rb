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

ActiveRecord::Schema.define(:version => 20131109155524) do

  create_table "items", :force => true do |t|
    t.decimal  "value",       :precision => 6, :scale => 2,                    :null => false
    t.string   "link",                                                         :null => false
    t.string   "name",                                                         :null => false
    t.string   "seller_rate",                                                  :null => false
    t.string   "img",                                                          :null => false
    t.string   "color"
    t.string   "size"
    t.integer  "order_id",                                                     :null => false
    t.string   "comment"
    t.integer  "status",                                    :default => 0,     :null => false
    t.integer  "count",                                     :default => 1,     :null => false
    t.datetime "created_at",                                                   :null => false
    t.datetime "updated_at",                                                   :null => false
    t.boolean  "havy",                                      :default => false
    t.string   "order_no"
    t.string   "track"
  end

  add_index "items", ["order_id", "created_at", "id"], :name => "index_items_on_order_id_and_created_at_and_id"

  create_table "lotts", :force => true do |t|
    t.decimal  "value",      :precision => 6, :scale => 2,                :null => false
    t.string   "name",                                                    :null => false
    t.string   "lot_number",                                              :null => false
    t.string   "color"
    t.string   "size"
    t.integer  "lot_id",                                   :default => 0, :null => false
    t.integer  "user_id",                                  :default => 0, :null => false
    t.string   "comment"
    t.integer  "status",                                   :default => 0, :null => false
    t.datetime "created_at",                                              :null => false
    t.datetime "updated_at",                                              :null => false
  end

  create_table "orders", :force => true do |t|
    t.integer  "status",                                    :default => 0,   :null => false
    t.integer  "user_id",                                                    :null => false
    t.datetime "created_at",                                                 :null => false
    t.datetime "updated_at",                                                 :null => false
    t.decimal  "order_value", :precision => 6, :scale => 2, :default => 0.0
  end

  add_index "orders", ["user_id", "created_at", "id"], :name => "index_orders_on_user_id_and_created_at_and_id"

  create_table "payments", :force => true do |t|
    t.date     "data",                                                    :null => false
    t.time     "time",                                                    :null => false
    t.decimal  "value",      :precision => 6, :scale => 2,                :null => false
    t.integer  "user_id",                                                 :null => false
    t.string   "comment"
    t.integer  "status",                                   :default => 0, :null => false
    t.datetime "created_at",                                              :null => false
    t.datetime "updated_at",                                              :null => false
  end

  add_index "payments", ["user_id", "created_at"], :name => "index_payments_on_user_id_and_created_at"

  create_table "products", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "image_url"
    t.decimal  "price",       :precision => 8, :scale => 2
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                                                :default => "",  :null => false
    t.string   "encrypted_password",                                   :default => "",  :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                                        :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                                            :null => false
    t.datetime "updated_at",                                                            :null => false
    t.string   "nik"
    t.decimal  "balance",                :precision => 6, :scale => 2, :default => 0.0, :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
