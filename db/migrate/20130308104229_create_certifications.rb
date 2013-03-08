class CreateCertifications < ActiveRecord::Migration
  def change
    create_table :certifications do |t|
      t.references :user, nil: false
      t.references :customer, nil: false
      t.integer :year, nil: false
      t.date :received_at
      t.attachment :attachment
      t.decimal :rate, precision: 8, scale: 2
      t.timestamps
    end
  end
end
