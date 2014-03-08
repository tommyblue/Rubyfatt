class CreateTokens < ActiveRecord::Migration
  def change
    create_table :tokens do |t|
      t.string :token, null: false, unique: true
      t.integer :user_id, null: false
      t.timestamps
    end
    add_index :tokens, :token
  end
end
