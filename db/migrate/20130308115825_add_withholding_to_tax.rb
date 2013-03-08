class AddWithholdingToTax < ActiveRecord::Migration
  def change
    add_column :taxes, :withholding, :boolean, default: false
  end
end
