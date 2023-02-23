class ShoppingCart < ApplicationRecord
  belongs_to :user
  has_many :line_items
  has_many :foods, through: :line_items

  def add_food(food, quantity = 1)
    current_item = line_items.find_by(food_id: food.id)
    if current_item
      current_item.quantity += quantity
      current_item.save
    else
      line_items.create(food_id: food.id, quantity: quantity, price: food.price)
    end
  end

  def total_price
    line_items.sum(:price)
  end

  def checkout
    user.orders.create(line_items: line_items)
  end
end