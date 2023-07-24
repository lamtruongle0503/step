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
class CouponsModule < ApplicationRecord
  self.inheritance_column = :_type_disabled

  belongs_to :module, polymorphic: true
  belongs_to :coupon

  scope :is_tours, -> { where(module_type: Tour.name) }
end
