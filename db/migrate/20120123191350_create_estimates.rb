class CreateEstimates < ActiveRecord::Migration
  def change
    create_table :estimates do |t|
      t.references :customer
      t.references :consolidated_tax
      t.date :date, :null => false
      t.integer :number, :null => false
      t.boolean :invoiced, :default => false
      t.timestamps
    end
  end
end
