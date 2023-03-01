class AddStripeProductIdToFood < ActiveRecord::Migration[7.0]
  def change
    add_column :foods, :stripe_product_id, :string
  end
end
