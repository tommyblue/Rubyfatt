class AddNotesToConsolidatedTax < ActiveRecord::Migration
  def change
    add_column :consolidated_taxes, :notes, :text
  end
end
