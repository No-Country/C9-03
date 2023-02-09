# == Schema Information
#
# Table name: stores
#
#  id          :bigint           not null, primary key
#  name        :string           not null
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
class Store < ApplicationRecord
    belongs_to :category
    has_one :address , dependent: :destroy
    has_many :foods, dependent: :destroy
end
