# frozen_string_literal: true

# == Schema Information
#
# Table name: product_sizes
#
#  id                :bigint           not null, primary key
#  color_name        :string
#  deleted_at        :datetime
#  is_color_name     :boolean          default(TRUE)
#  is_limit          :boolean          default(FALSE)
#  is_product_size   :boolean          default(TRUE)
#  name              :string
#  option_color_name :string
#  option_size_name  :string
#  price             :float
#  remaining_count   :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  product_id        :bigint
#
# Indexes
#
#  index_product_sizes_on_product_id  (product_id)
#
# Foreign Keys
#
#  fk_rails_...  (product_id => products.id)
#
FactoryBot.define do
  factory :product_size do
    association :product
    name { %w[X M L XL].sample }
    price { rand(10.0..20.0).round(2) }
  end
end
