class AddUserToAddresses < ActiveRecord::Migration[7.0]
  def change
    add_reference :addresses, :users, foreign_key: true
  end
end
