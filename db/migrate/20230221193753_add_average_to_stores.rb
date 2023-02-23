class AddAverageToStores < ActiveRecord::Migration[7.0]
  def change
    add_column :stores, :average, :float
  end
end
