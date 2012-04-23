class AddIndexes < ActiveRecord::Migration
  def up
    add_index :customers, :title
    add_index :customers, :name
    add_index :customers, :surname
    
    add_index :slips, :name
    
    add_index :taxes, :name
    
    add_index :consolidated_taxes, :name
    
    add_index :estimates, :date
    add_index :estimates, :number
    add_index :estimates, :invoiced
    
    add_index :invoices, :date
    add_index :invoices, :number
    add_index :invoices, :paid
    
    add_index :options, :name
    
    add_index :recurring_slips, :name
    
    add_index :invoice_projects, :date
    add_index :invoice_projects, :number
    add_index :invoice_projects, :invoiced
  end

  def down
  end
end
