class CreateTimeEntries < ActiveRecord::Migration
  def change
    create_table :time_entries do |t|
      t.references :slip
      t.references :work_category
      t.date :date
      t.float :hours
      t.string :comments
      t.timestamps
    end
    add_index :time_entries, :slip_id
    add_index :time_entries, :work_category_id
  end
end
