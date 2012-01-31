class CreateRecurringSlips < ActiveRecord::Migration
  def change
    create_table :recurring_slips do |t|
      t.references :customer, :null => false
      t.string :schedule, :null => false
      t.datetime :last_occurrence
      t.datetime :next_occurrence, :null => false
      t.string :name, :null => false
      t.decimal :rate, :precision => 8, :scale => 2, :null => false
    end
  end
end
