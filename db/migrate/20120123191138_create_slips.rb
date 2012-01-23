class CreateSlips < ActiveRecord::Migration
  def change
    create_table :slips do |t|
      t.references :customer
      t.references :estimate
      t.references :invoice
      t.references :consolidated_tax
      t.string :name
      t.integer :price_cents, :default => 0, :null => false
      t.string :currency
      t.timestamps
    end
  end
end
