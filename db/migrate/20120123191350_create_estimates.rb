class CreateEstimates < ActiveRecord::Migration
  def change
    create_table :estimates do |t|
      t.references :customers
      t.date :date
      t.integer :year
      t.integer :number
      t.boolean :invoiced
      t.timestamps
    end
  end
end
