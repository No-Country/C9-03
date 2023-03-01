class AddShoppingCartRefToOrders < ActiveRecord::Migration[7.0]
  def change
    add_reference :orders, :shopping_cart, null: false, foreign_key: true
  end
end
