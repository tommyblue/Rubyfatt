class CreateTaxes < ActiveRecord::Migration
  def change
    create_table :taxes do |t|
      t.references :consolidated_tax
      t.references :user
      t.integer :order
      t.string :name
      t.integer :rate
      t.boolean :compound
    end
  end
end
