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
class ProductSize < ApplicationRecord
  acts_as_paranoid

  belongs_to :product, -> { with_deleted }, inverse_of: :product_sizes
end
