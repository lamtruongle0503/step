# frozen_string_literal: true

# == Schema Information
#
# Table name: payments_products
#
#  id         :bigint           not null, primary key
#  deleted_at :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  payment_id :bigint
#  product_id :bigint
#
# Indexes
#
#  index_payments_products_on_payment_id  (payment_id)
#  index_payments_products_on_product_id  (product_id)
#
# Foreign Keys
#
#  fk_rails_...  (payment_id => payments.id)
#  fk_rails_...  (product_id => products.id)
#
FactoryBot.define do
  factory :payments_product do
    association :product
    association :payment
  end
end
