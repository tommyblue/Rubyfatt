class LinkInvoiceToInvoiceProject < ActiveRecord::Migration
  def up
    add_column :invoices, :invoice_project_id, :integer, :nil => true
  end

  def down
    remove_column :invoices, :invoice_project_id
  end
end
