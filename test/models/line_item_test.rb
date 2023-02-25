# == Schema Information
#
# Table name: line_items
#
#  id               :bigint           not null, primary key
#  price            :decimal(, )
#  quantity         :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  food_id          :bigint           not null
#  shopping_cart_id :bigint           not null
#
# Indexes
#
#  index_line_items_on_food_id           (food_id)
#  index_line_items_on_shopping_cart_id  (shopping_cart_id)
#
# Foreign Keys
#
#  fk_rails_...  (food_id => foods.id)
#  fk_rails_...  (shopping_cart_id => shopping_carts.id)
#
require "test_helper"

class LineItemTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
