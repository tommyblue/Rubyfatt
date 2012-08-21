class RemoveUserIdFromTax < ActiveRecord::Migration
  def up
    remove_column :taxes, :user_id
  end

  def down
    add_column :taxes, :user_id, :integer
  end
end
