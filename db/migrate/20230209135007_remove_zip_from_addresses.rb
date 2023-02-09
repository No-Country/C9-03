class RemoveZipFromAddresses < ActiveRecord::Migration[7.0]
  def change
    remove_column :addresses, :zip
  end
end
