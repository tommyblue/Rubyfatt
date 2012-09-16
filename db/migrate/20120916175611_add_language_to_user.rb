class AddLanguageToUser < ActiveRecord::Migration
  def change
    add_column :users, :language, :string, :default => "it"
  end
end
