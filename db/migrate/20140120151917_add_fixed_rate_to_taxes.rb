class AddFixedRateToTaxes < ActiveRecord::Migration
  def change
    add_column :taxes, :fixed_rate, :boolean, default: false, after: :rate
  end
end
