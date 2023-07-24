# frozen_string_literal: true

# == Schema Information
#
# Table name: coupons_modules
#
#  id          :bigint           not null, primary key
#  module_type :string           not null
#  type        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  coupon_id   :bigint           not null
#  module_id   :bigint           not null
#
# Indexes
#
#  index_coupons_modules_on_coupon_id  (coupon_id)
#  index_coupons_modules_on_module     (module_type,module_id)
#
# Foreign Keys
#
#  fk_rails_...  (coupon_id => coupons.id)
#
FactoryBot.define do
  factory :coupons_module do
    association :coupon
    trait :with_product do
      association :module, factory: :product
    end
    trait :with_tour do
      association :module, factory: :user
    end
  end
end
