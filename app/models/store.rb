# == Schema Information
#
# Table name: stores
#
#  id          :bigint           not null, primary key
#  average     :float
#  description :string
#  name        :string           not null
#  ratings     :float            default([]), is an Array
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
class Store < ApplicationRecord
    belongs_to :category
    has_one :location , dependent: :destroy
    has_many :foods, dependent: :destroy
    has_one_attached :image
    before_save :update_average
    scope :filter_by_ratings, ->(ratings) { where('average >= ?', ratings )}
    def update_average
        avg = 0
        self.ratings.each { |x| avg += x }
        self.average = avg/self.ratings.length
    end
end
  