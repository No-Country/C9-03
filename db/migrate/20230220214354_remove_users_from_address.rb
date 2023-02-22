class RemoveUsersFromAddress < ActiveRecord::Migration[7.0]
  def change
    remove_reference :locations, :users
  end
end
