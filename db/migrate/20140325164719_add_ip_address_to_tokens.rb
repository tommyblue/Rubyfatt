class AddIpAddressToTokens < ActiveRecord::Migration
  def change
    add_column :tokens, :ip_address, :string, after: :user_id
  end
end
