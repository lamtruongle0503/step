# frozen_string_literal: true

# == Schema Information
#
# Table name: delivery_settings
#
#  id         :bigint           not null, primary key
#  deleted_at :datetime
#  is_free    :boolean          default(TRUE)
#  memo       :string
#  other      :string
#  price      :float
#  vendor     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  product_id :bigint
#
# Indexes
#
#  index_delivery_settings_on_product_id  (product_id)
#
# Foreign Keys
#
#  fk_rails_...  (product_id => products.id)
#
FactoryBot.define do
  factory :delivery_setting do
    association :product
    vendor { Faker::Tea.type }
    memo { Faker::Tea.type }
    other { Faker::Tea.type }
    price { rand(10.0..20.0).round(2) }
    is_free { [true, false].sample }
  end
end
