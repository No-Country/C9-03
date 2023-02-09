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
class Address < ApplicationRecord
  belongs_to :store
  geocoded_by :address
  after_validation :geocode

  def address
    self.street
  end
end
