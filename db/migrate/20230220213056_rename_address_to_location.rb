class RenameAddressToLocation < ActiveRecord::Migration[7.0]
  def change
    rename_table :addresses, :locations
  end
end
