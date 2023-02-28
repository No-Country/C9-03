# == Schema Information
#
# Table name: orders
#
#  id               :bigint           not null, primary key
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  shopping_cart_id :bigint
#  user_id          :bigint           not null
#
# Indexes
#
#  index_orders_on_shopping_cart_id  (shopping_cart_id)
#  index_orders_on_user_id           (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require "test_helper"

class OrderTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
