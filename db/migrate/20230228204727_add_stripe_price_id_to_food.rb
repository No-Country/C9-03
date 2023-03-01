class AddStripePriceIdToFood < ActiveRecord::Migration[7.0]
  def change
    add_column :foods, :stripe_price_id, :string
  end
end
