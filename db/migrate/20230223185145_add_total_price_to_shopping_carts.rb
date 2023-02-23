class AddTotalPriceToShoppingCarts < ActiveRecord::Migration[7.0]
  def change
    add_column :shopping_carts, :total_price, :decimal, precision: 10, scale: 2, default: 0.0
  end
end