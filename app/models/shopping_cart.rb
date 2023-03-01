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
  has_many :line_items
  has_many :foods, through: :line_items

  def add_food(food, quantity = 1)
    current_item = line_items.find_by(food_id: food.id)
    if current_item
      current_item.quantity += quantity.to_i
      current_item.save
    else
      line_items.create(food_id: food.id, quantity: quantity, price: food.price)
    end
  end
  
  def remove_food(food)
    current_item = line_items.find_by(food_id: food.id)
    if current_item
      current_item.quantity -= 1
      if current_item.quantity < 1
        current_item.destroy
      else
        current_item.save
      end
    end
  end

  def total_price
    line_items.sum(:price)
  end

  def checkout
    user.orders.create(line_items: line_items)
  end
end
