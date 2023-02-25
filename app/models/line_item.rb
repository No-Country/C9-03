class LineItem < ApplicationRecord
  belongs_to :food
  belongs_to :shopping_cart
end