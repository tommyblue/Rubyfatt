class CreateWorkCategories < ActiveRecord::Migration
  def change
    create_table :work_categories do |t|
      t.references :user
      t.string :label, :uniq => true, :null => false
    end

    add_index :work_categories, :user_id
    add_index :work_categories, :label
  end
end
