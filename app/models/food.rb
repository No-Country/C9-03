# == Schema Information
#
# Table name: foods
#
#  id                :bigint           not null, primary key
#  name              :string           not null
#  price             :integer          not null
#  url               :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  store_id          :bigint           not null
#  stripe_price_id   :string
#  stripe_product_id :string
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
  after_create :create_stripe_product, :create_stripe_price
  has_one_attached :image

  #move this to a helper in a future

  def create_stripe_product
    self.stripe_product_id = Stripe::Product.create(
      name: self.name,
    ).id
    self.save
  end
  def create_stripe_price
    if self.stripe_product_id
      self.stripe_price_id = Stripe::Price.create(
        unit_amount: self.price,
        currency: 'usd',
        product: self.stripe_product_id,
      ).id
      self.save
    else
      puts "Stripe product does not exist for this food"
    end
  end
end
