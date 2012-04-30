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

ActiveRecord::Schema.define(:version => 20120430201357) do

  create_table "consolidated_taxes", :force => true do |t|
    t.integer "user_id"
    t.string  "name"
  end

  add_index "consolidated_taxes", ["name"], :name => "index_consolidated_taxes_on_name"

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

  add_index "customers", ["name"], :name => "index_customers_on_name"
  add_index "customers", ["surname"], :name => "index_customers_on_surname"
  add_index "customers", ["title"], :name => "index_customers_on_title"

  create_table "estimates", :force => true do |t|
    t.integer  "customer_id"
    t.integer  "consolidated_tax_id"
    t.date     "date",                                   :null => false
    t.integer  "number",                                 :null => false
    t.boolean  "invoiced",            :default => false
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "estimates", ["date"], :name => "index_estimates_on_date"
  add_index "estimates", ["invoiced"], :name => "index_estimates_on_invoiced"
  add_index "estimates", ["number"], :name => "index_estimates_on_number"

  create_table "invoice_projects", :force => true do |t|
    t.integer  "customer_id"
    t.integer  "consolidated_tax_id"
    t.date     "date",                                   :null => false
    t.integer  "number",                                 :null => false
    t.boolean  "invoiced",            :default => false
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "invoice_projects", ["date"], :name => "index_invoice_projects_on_date"
  add_index "invoice_projects", ["invoiced"], :name => "index_invoice_projects_on_invoiced"
  add_index "invoice_projects", ["number"], :name => "index_invoice_projects_on_number"

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

  add_index "invoices", ["date"], :name => "index_invoices_on_date"
  add_index "invoices", ["number"], :name => "index_invoices_on_number"
  add_index "invoices", ["paid"], :name => "index_invoices_on_paid"

  create_table "options", :force => true do |t|
    t.integer "user_id"
    t.string  "name"
    t.string  "value"
    t.boolean "integer", :default => false
  end

  add_index "options", ["name"], :name => "index_options_on_name"

  create_table "recurring_slips", :force => true do |t|
    t.integer  "customer_id"
    t.string   "name"
    t.decimal  "rate",            :precision => 8, :scale => 2
    t.string   "schedule",                                      :default => "", :null => false
    t.datetime "last_occurrence"
    t.datetime "next_occurrence",                                               :null => false
  end

  add_index "recurring_slips", ["name"], :name => "index_recurring_slips_on_name"

  create_table "slips", :force => true do |t|
    t.integer  "customer_id"
    t.integer  "estimate_id"
    t.integer  "invoice_id"
    t.string   "name"
    t.decimal  "rate",               :precision => 8, :scale => 2
    t.datetime "created_at",                                       :null => false
    t.datetime "updated_at",                                       :null => false
    t.boolean  "timed"
    t.integer  "duration"
    t.integer  "invoice_project_id"
  end

  add_index "slips", ["name"], :name => "index_slips_on_name"

  create_table "taxes", :force => true do |t|
    t.integer "consolidated_tax_id"
    t.integer "user_id"
    t.integer "order"
    t.string  "name"
    t.integer "rate"
    t.boolean "compound"
  end

  add_index "taxes", ["name"], :name => "index_taxes_on_name"

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
    t.text     "bank_coordinates"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
