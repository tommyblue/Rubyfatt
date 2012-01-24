class CreateConsolidatedTaxes < ActiveRecord::Migration
  def change
    create_table :consolidated_taxes do |t|
      t.references :user
      t.string :name
    end
  end
end
