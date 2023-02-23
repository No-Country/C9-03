class RenameAddressFromUsersToLocation < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :address
    add_reference :users, :location 
  end
end
