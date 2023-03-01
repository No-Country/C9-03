# == Schema Information
#
# Table name: shopping_carts
#
#  id          :bigint           not null, primary key
#  total_price :decimal(10, 2)   default(0.0)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :bigint           not null
#
# Indexes
#
#  index_shopping_carts_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class ShoppingCart < ApplicationRecord
  belongs_to :user
  has_many :foods, through: :line_items
  has_many :line_items, dependent: :destroy
  has_one :order, dependent: :destroy

  def add_food(food, quantity = 1)
    current_item = line_items.find_by(food_id: food.id)
    if current_item
      current_item.quantity += quantity.to_i
      current_item.price = current_item.quantity * current_item.food.price
      
      current_item.save
    else
      current_item = line_items.build(food_id: food.id, quantity: quantity)
      current_item.price = current_item.quantity * current_item.food.price
      current_item.save
    end
    current_item
  end  
  def remove_food(food)
    current_item = line_items.find_by(food_id: food.id)
    if current_item.quantity > 1
      current_item.quantity -= 1
      current_item.price = current_item.quantity * current_item.food.price
      current_item.save
    else
      current_item.destroy
    end
    current_item
  end

  def total_price
    line_items.to_a.sum { |item| item.price }
  end

  def checkout
    user.orders.create(shopping_cart: self)
  end
end
