class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.references :customer
      t.references :consolidated_tax
      t.date :date, :null => false
      t.integer :number, :null => false
      t.boolean :paid, :default => false
      t.date :payment_date
      t.timestamps
    end
  end
end
