class AddBankCoordinates < ActiveRecord::Migration
  def up
    say "Adding BANK_COORDINATES option to users with default data, please change it!"
    User.all.each do |user|
      unless user.options.find_by_name("BANK_COORDINATES")
        user.options.create([{:name => 'BANK_COORDINATES', :value => "Intestatario: Name Surname\nBanca: MyBank\nCC 000012345678\nABI 01234\nCAB 54321\nIBAN IT37L0123454321000012345678", :integer => false}])
      end
    end
  end

  def down
  end
end