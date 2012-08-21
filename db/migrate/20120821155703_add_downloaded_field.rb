class AddDownloadedField < ActiveRecord::Migration
  def up
    add_column :invoice_projects, :downloaded, :boolean, :default => false
    add_column :invoices, :downloaded, :boolean, :default => false
  end

  def down
    remove_column :invoices, :downloaded
    remove_column :invoice_projects, :downloaded
  end
end
