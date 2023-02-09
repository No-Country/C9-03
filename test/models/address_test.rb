# == Schema Information
#
# Table name: addresses
#
#  id         :bigint           not null, primary key
#  latitude   :float
#  longitude  :float
#  street     :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  store_id   :bigint           not null
#
# Indexes
#
#  index_addresses_on_store_id  (store_id)
#
# Foreign Keys
#
#  fk_rails_...  (store_id => stores.id)
#
require "test_helper"

class AddressTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
