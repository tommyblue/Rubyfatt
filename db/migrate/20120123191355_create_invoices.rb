class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.references :customers
      t.date :date
      t.integer :year
      t.integer :number
      t.boolean :paid
      t.timestamps
    end
  end
end
