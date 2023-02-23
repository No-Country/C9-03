# == Schema Information
#
# Table name: foods
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  price      :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  store_id   :bigint           not null
#
# Indexes
#
#  index_foods_on_store_id  (store_id)
#
# Foreign Keys
#
#  fk_rails_...  (store_id => stores.id)
#
class Food < ApplicationRecord
  belongs_to :store
  has_and_belongs_to_many :shopping_cart, optional: true
end
