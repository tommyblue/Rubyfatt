class AddInfoToCustomers < ActiveRecord::Migration
  def change
    add_column :customers, :info, :text
  end
end
