class CreateConsolidatedTaxes < ActiveRecord::Migration
  def change
    create_table :consolidated_taxes do |t|
      t.string :name
    end
  end
end
