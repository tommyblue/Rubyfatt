class AddMissingUniqIndexes < ActiveRecord::Migration
  def up
    # This migration fixes the errors revealed by the consistency_fail gem
    #
    # ~$ consistency_fail
    #
    # There are calls to validates_uniqueueness_of that aren't backed by uniqueue indexes.
    # --------------------------------------------------------------------------------
    # Model            Table Columns
    # --------------------------------------------------------------------------------
    # ConsolidatedTax  consolidated_taxes (name, user_id)
    # Customer         customers (title, user_id)
    # Customer         customers (vat, user_id)
    # Option           options (name, user_id)
    # Tax              taxes (name, consolidated_tax_id)
    # WikiPage         wiki_pages (title)
    # WorkCategory     work_categories (label)
    # --------------------------------------------------------------------------------
    #
    # There are calls to has_one that aren't backed by unique indexes.
    # --------------------------------------------------------------------------------
    # Model           Table Columns
    # --------------------------------------------------------------------------------
    #   InvoiceProject  invoices (invoice_project_id)
    # RecurringSlip   users (user_id)
    # --------------------------------------------------------------------------------

    add_index :consolidated_taxes, [:name, :user_id], unique: true
    add_index :customers, [:title, :user_id], unique: true
    add_index :options, [:name, :user_id], unique: true
    add_index :taxes, [:name, :consolidated_tax_id], unique: true
    add_index :wiki_pages, :title, unique: true

    remove_index :work_categories, :label
    add_index :work_categories, :label, unique: true

    remove_index :invoices, :invoice_project_id
    add_index :invoices, :invoice_project_id, unique: true
  end

  def down
    remove_index :wiki_pages, :title
    remove_index :taxes, [:name, :consolidated_tax_id]
    remove_index :options, [:name, :user_id]
    remove_index :customers, [:title, :user_id]
    remove_index :consolidated_taxes, [:name, :user_id]
  end
end
