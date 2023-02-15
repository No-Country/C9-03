class AddUrlToStores < ActiveRecord::Migration[7.0]
  def change
    add_column :stores, :url, :string
    add_column :stores, :description, :string
  end
end
