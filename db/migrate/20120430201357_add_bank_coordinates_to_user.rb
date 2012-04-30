class AddBankCoordinatesToUser < ActiveRecord::Migration
  def up
    say "Adding bank coordinates to User"
    add_column :users, :bank_coordinates, :text
    say "Copying bank coordinates from options to users"
    User.all.each do |user|
      option = user.options.find_by_name("BANK_COORDINATES")
      if option
        user.update_attribute(:bank_coordinates, option.value)
        Option.destroy(option)
      end
    end
  end
  
  def down
  end
end
