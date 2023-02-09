class DeleteStoresIdFromAddresses < ActiveRecord::Migration[7.0]
  def change
    remove_reference :addresses, :stores, index: true, foreign_key: true
  end
end
