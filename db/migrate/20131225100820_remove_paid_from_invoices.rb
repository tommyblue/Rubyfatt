class RemovePaidFromInvoices < ActiveRecord::Migration
  def up
    remove_column :invoices, :paid
  end

  def down
    add_column :invoices, :paid, :boolean, default: false
  end
end
