# == Schema Information
#
# Table name: addresses
#
#  id         :bigint           not null, primary key
#  street     :string           not null
#  zip        :integer          not null
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
class Address < ApplicationRecord
  belongs_to :store
end
