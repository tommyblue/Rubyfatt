class CreateSlips < ActiveRecord::Migration
  def change
    create_table :slips do |t|
      t.references :customer
      t.references :estimate
      t.references :invoice
      t.string :name
      t.decimal :rate, :precision => 8, :scale => 2
      t.timestamps
    end
  end
end
