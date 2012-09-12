class AddMoreIndexes < ActiveRecord::Migration
  def change
    add_index :consolidated_taxes, :user_id
    add_index :customers, :user_id
    add_index :options , :user_id
    add_index :recurring_slips , :customer_id
    add_index :slips, :customer_id
    add_index :slips, :estimate_id
    add_index :slips, :invoice_id
    add_index :slips, :invoice_project_id
    add_index :estimates , :customer_id
    add_index :estimates, :consolidated_tax_id
    add_index :invoice_projects, :customer_id
    add_index :invoice_projects, :consolidated_tax_id
    add_index :invoices, :customer_id
    add_index :invoices, :consolidated_tax_id
    add_index :invoices, :invoice_project_id
    add_index :taxes, :consolidated_tax_id
  end
end
