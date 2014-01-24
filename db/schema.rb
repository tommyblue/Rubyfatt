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

ActiveRecord::Schema.define(version: 20140124151429) do

  create_table "certifications", force: true do |t|
    t.integer  "user_id"
    t.integer  "customer_id"
    t.integer  "year"
    t.date     "received_at"
    t.string   "attachment_file_name"
    t.string   "attachment_content_type"
    t.integer  "attachment_file_size"
    t.datetime "attachment_updated_at"
    t.decimal  "rate",                    precision: 8, scale: 2
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
  end

  create_table "consolidated_taxes", force: true do |t|
    t.integer "user_id"
    t.string  "name"
    t.text    "notes"
  end

  add_index "consolidated_taxes", ["name", "user_id"], name: "index_consolidated_taxes_on_name_and_user_id", unique: true, using: :btree
  add_index "consolidated_taxes", ["name"], name: "index_consolidated_taxes_on_name", using: :btree
  add_index "consolidated_taxes", ["user_id"], name: "index_consolidated_taxes_on_user_id", using: :btree

  create_table "customers", force: true do |t|
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
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text     "info"
  end

  add_index "customers", ["name"], name: "index_customers_on_name", using: :btree
  add_index "customers", ["surname"], name: "index_customers_on_surname", using: :btree
  add_index "customers", ["title", "user_id"], name: "index_customers_on_title_and_user_id", unique: true, using: :btree
  add_index "customers", ["title"], name: "index_customers_on_title", using: :btree
  add_index "customers", ["user_id"], name: "index_customers_on_user_id", using: :btree

  create_table "estimates", force: true do |t|
    t.integer  "customer_id"
    t.integer  "consolidated_tax_id"
    t.date     "date",                                null: false
    t.integer  "number",                              null: false
    t.boolean  "invoiced",            default: false
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "estimates", ["consolidated_tax_id"], name: "index_estimates_on_consolidated_tax_id", using: :btree
  add_index "estimates", ["customer_id"], name: "index_estimates_on_customer_id", using: :btree
  add_index "estimates", ["date"], name: "index_estimates_on_date", using: :btree
  add_index "estimates", ["invoiced"], name: "index_estimates_on_invoiced", using: :btree
  add_index "estimates", ["number"], name: "index_estimates_on_number", using: :btree

  create_table "invoice_projects", force: true do |t|
    t.integer  "customer_id"
    t.integer  "consolidated_tax_id"
    t.date     "date",                                null: false
    t.integer  "number",                              null: false
    t.boolean  "invoiced",            default: false
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.boolean  "downloaded",          default: false
  end

  add_index "invoice_projects", ["consolidated_tax_id"], name: "index_invoice_projects_on_consolidated_tax_id", using: :btree
  add_index "invoice_projects", ["customer_id"], name: "index_invoice_projects_on_customer_id", using: :btree
  add_index "invoice_projects", ["date"], name: "index_invoice_projects_on_date", using: :btree
  add_index "invoice_projects", ["invoiced"], name: "index_invoice_projects_on_invoiced", using: :btree
  add_index "invoice_projects", ["number"], name: "index_invoice_projects_on_number", using: :btree

  create_table "invoices", force: true do |t|
    t.integer  "customer_id"
    t.integer  "consolidated_tax_id"
    t.date     "date",                                null: false
    t.integer  "number",                              null: false
    t.date     "payment_date"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "invoice_project_id"
    t.boolean  "downloaded",          default: false
  end

  add_index "invoices", ["consolidated_tax_id"], name: "index_invoices_on_consolidated_tax_id", using: :btree
  add_index "invoices", ["customer_id"], name: "index_invoices_on_customer_id", using: :btree
  add_index "invoices", ["date"], name: "index_invoices_on_date", using: :btree
  add_index "invoices", ["invoice_project_id"], name: "index_invoices_on_invoice_project_id", unique: true, using: :btree
  add_index "invoices", ["number"], name: "index_invoices_on_number", using: :btree

  create_table "options", force: true do |t|
    t.integer "user_id"
    t.string  "name"
    t.string  "value"
    t.boolean "integer", default: false
  end

  add_index "options", ["name", "user_id"], name: "index_options_on_name_and_user_id", unique: true, using: :btree
  add_index "options", ["name"], name: "index_options_on_name", using: :btree
  add_index "options", ["user_id"], name: "index_options_on_user_id", using: :btree

  create_table "recurring_slips", force: true do |t|
    t.integer  "customer_id",                             null: false
    t.string   "schedule",                                null: false
    t.datetime "last_occurrence"
    t.datetime "next_occurrence",                         null: false
    t.string   "name",                                    null: false
    t.decimal  "rate",            precision: 8, scale: 2, null: false
  end

  add_index "recurring_slips", ["customer_id"], name: "index_recurring_slips_on_customer_id", using: :btree
  add_index "recurring_slips", ["name"], name: "index_recurring_slips_on_name", using: :btree

  create_table "slips", force: true do |t|
    t.integer  "customer_id",                                                null: false
    t.integer  "estimate_id"
    t.integer  "invoice_id"
    t.string   "name",                                                       null: false
    t.decimal  "rate",               precision: 8, scale: 2,                 null: false
    t.boolean  "timed",                                      default: false
    t.integer  "duration"
    t.datetime "created_at",                                                 null: false
    t.datetime "updated_at",                                                 null: false
    t.integer  "invoice_project_id"
  end

  add_index "slips", ["customer_id"], name: "index_slips_on_customer_id", using: :btree
  add_index "slips", ["estimate_id"], name: "index_slips_on_estimate_id", using: :btree
  add_index "slips", ["invoice_id"], name: "index_slips_on_invoice_id", using: :btree
  add_index "slips", ["invoice_project_id"], name: "index_slips_on_invoice_project_id", using: :btree
  add_index "slips", ["name"], name: "index_slips_on_name", using: :btree

  create_table "taxes", force: true do |t|
    t.integer "consolidated_tax_id"
    t.integer "order"
    t.string  "name"
    t.integer "rate"
    t.boolean "fixed_rate",          default: false
    t.boolean "compound"
    t.boolean "withholding",         default: false
  end

  add_index "taxes", ["consolidated_tax_id"], name: "index_taxes_on_consolidated_tax_id", using: :btree
  add_index "taxes", ["name", "consolidated_tax_id"], name: "index_taxes_on_name_and_consolidated_tax_id", unique: true, using: :btree
  add_index "taxes", ["name"], name: "index_taxes_on_name", using: :btree

  create_table "time_entries", force: true do |t|
    t.integer  "slip_id"
    t.integer  "work_category_id"
    t.date     "date"
    t.float    "hours"
    t.string   "comments"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "time_entries", ["slip_id"], name: "index_time_entries_on_slip_id", using: :btree
  add_index "time_entries", ["work_category_id"], name: "index_time_entries_on_work_category_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "title"
    t.string   "name",                                              null: false
    t.string   "surname",                                           null: false
    t.string   "address",                                           null: false
    t.string   "zip_code",                                          null: false
    t.string   "town",                                              null: false
    t.string   "province",                                          null: false
    t.string   "country"
    t.string   "tax_code",                                          null: false
    t.string   "vat",                                               null: false
    t.string   "phone",                                             null: false
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
    t.string   "email",                              default: "",   null: false
    t.string   "encrypted_password",     limit: 128, default: "",   null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.text     "bank_coordinates"
    t.string   "language",                           default: "it"
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "wiki_page_versions", force: true do |t|
    t.integer  "page_id",    null: false
    t.integer  "updator_id"
    t.integer  "number"
    t.string   "comment"
    t.string   "path"
    t.string   "title"
    t.text     "content"
    t.datetime "updated_at"
  end

  add_index "wiki_page_versions", ["page_id"], name: "index_wiki_page_versions_on_page_id", using: :btree
  add_index "wiki_page_versions", ["updator_id"], name: "index_wiki_page_versions_on_updator_id", using: :btree

  create_table "wiki_pages", force: true do |t|
    t.integer  "creator_id"
    t.integer  "updator_id"
    t.string   "path"
    t.string   "title"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "wiki_pages", ["creator_id"], name: "index_wiki_pages_on_creator_id", using: :btree
  add_index "wiki_pages", ["path"], name: "index_wiki_pages_on_path", unique: true, using: :btree
  add_index "wiki_pages", ["title"], name: "index_wiki_pages_on_title", unique: true, using: :btree

  create_table "work_categories", force: true do |t|
    t.integer "user_id"
    t.string  "label",   null: false
  end

  add_index "work_categories", ["label"], name: "index_work_categories_on_label", unique: true, using: :btree
  add_index "work_categories", ["user_id"], name: "index_work_categories_on_user_id", using: :btree

end
