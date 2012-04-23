class AddInvoiceProjectToSlips < ActiveRecord::Migration
  def change
    add_column :slips, :invoice_project_id, :int
  end
end
