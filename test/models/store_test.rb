# == Schema Information
#
# Table name: stores
#
#  id          :bigint           not null, primary key
#  description :string
#  name        :string           not null
#  url         :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :bigint
#
# Indexes
#
#  index_stores_on_category_id  (category_id)
#
# Foreign Keys
#
#  fk_rails_...  (category_id => categories.id)
#
require "test_helper"

class StoreTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
