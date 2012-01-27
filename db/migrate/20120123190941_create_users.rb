class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name, :null => false
      t.string :surname, :null => false
      t.string :address, :null => false
      t.string :zip_code, :null => false
      t.string :town, :null => false
      t.string :province, :null => false
      t.string :country
      t.string :tax_code, :null => false
      t.string :vat, :null => false
      t.string :phone, :null => false
      t.timestamps
    end
  end
end
