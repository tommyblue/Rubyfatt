class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :surname
      t.string :address
      t.string :zip_code
      t.string :town
      t.string :province
      t.string :country
      t.string :tax_code
      t.string :vat
      t.timestamps
    end
  end
end
