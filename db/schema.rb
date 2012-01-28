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

ActiveRecord::Schema.define(:version => 20120128174149) do

  create_table "consolidated_taxes", :force => true do |t|
    t.integer "user_id"
    t.string  "name"
  end

  create_table "customers", :force => true do |t|
    t.integer  "user_id"
    t.string   "title"
    t.string   "name"
    t.string   "surname"
    t.string   "address"
    t.string   "zip_code"
    t.string   "town"
    t.string   "province"
    t.string   "country"
    t.string   "tax_code"
    t.string   "vat"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "estimates", :force => true do |t|
    t.integer  "customer_id"
    t.integer  "consolidated_tax_id"
    t.date     "date",                                   :null => false
    t.integer  "number",                                 :null => false
    t.boolean  "invoiced",            :default => false
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  create_table "invoices", :force => true do |t|
    t.integer  "customer_id"
    t.integer  "consolidated_tax_id"
    t.date     "date",                                   :null => false
    t.integer  "number",                                 :null => false
    t.boolean  "paid",                :default => false
    t.date     "payment_date"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  create_table "options", :force => true do |t|
    t.integer "user_id"
    t.string  "name"
    t.string  "value"
    t.boolean "integer", :default => false
  end

  create_table "recurring_slips", :force => true do |t|
    t.integer "customer_id"
    t.integer "estimate_id"
    t.integer "invoice_id"
    t.string  "name"
    t.decimal "rate",        :precision => 8, :scale => 2
  end

  create_table "slips", :force => true do |t|
    t.integer  "customer_id"
    t.integer  "estimate_id"
    t.integer  "invoice_id"
    t.string   "name"
    t.decimal  "rate",        :precision => 8, :scale => 2
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.boolean  "timed"
    t.integer  "duration"
  end

  create_table "taxes", :force => true do |t|
    t.integer "consolidated_tax_id"
    t.integer "user_id"
    t.integer "order"
    t.string  "name"
    t.integer "rate"
    t.boolean "compound"
  end

  create_table "users", :force => true do |t|
    t.string   "name",                                                  :null => false
    t.string   "surname",                                               :null => false
    t.string   "address",                                               :null => false
    t.string   "zip_code",                                              :null => false
    t.string   "town",                                                  :null => false
    t.string   "province",                                              :null => false
    t.string   "country"
    t.string   "tax_code",                                              :null => false
    t.string   "vat",                                                   :null => false
    t.string   "phone",                                                 :null => false
    t.datetime "created_at",                                            :null => false
    t.datetime "updated_at",                                            :null => false
    t.string   "email",                                 :default => "", :null => false
    t.string   "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
