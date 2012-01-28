class CreateSlips < ActiveRecord::Migration
  def change
    create_table :slips do |t|
      t.references :customer, :null => false
      t.references :estimate
      t.references :invoice
      t.string :name, :null => false
      t.decimal :rate, :precision => 8, :scale => 2, :null => false
      t.boolean :timed, :default => false
      t.integer :duration
      t.timestamps
    end
  end
end
