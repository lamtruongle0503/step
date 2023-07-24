# frozen_string_literal: true

# == Schema Information
#
# Table name: order_products
#
#  id               :bigint           not null, primary key
#  color            :string
#  deleted_at       :datetime
#  discount         :float            default(100.0)
#  number           :integer
#  price            :float
#  purchased_amount :float
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  order_id         :bigint
#  product_id       :bigint
#  product_size_id  :integer
#
# Indexes
#
#  index_order_products_on_order_id    (order_id)
#  index_order_products_on_product_id  (product_id)
#
# Foreign Keys
#
#  fk_rails_...  (order_id => orders.id)
#  fk_rails_...  (product_id => products.id)
#
FactoryBot.define do
  factory :order_product do
    association :order
    association :product_size
    price { rand(10.0..20.0).round(2) }
    number { rand(1..10) }
    purchased_amount { number * price.round(2) }
    color { Faker::Tea.type }
    discount { rand(10.0..50.0).round(2) }
  end
end
