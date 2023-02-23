# == Schema Information
#
# Table name: locations
#
#  id         :bigint           not null, primary key
#  latitude   :float
#  longitude  :float
#  street     :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  store_id   :bigint
#
# Indexes
#
#  index_locations_on_store_id  (store_id)
#
# Foreign Keys
#
#  fk_rails_...  (store_id => stores.id)
#
class Location < ApplicationRecord
  belongs_to :store, optional: true
  geocoded_by :address
  after_validation :geocode

  def address
    self.street
  end

  def type
    self.store_id != nil ? "STORE" : "USER"
  end
end
