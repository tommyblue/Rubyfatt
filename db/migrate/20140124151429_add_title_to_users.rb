class AddTitleToUsers < ActiveRecord::Migration
  def change
    add_column :users, :title, :string, after: :id
  end
end
