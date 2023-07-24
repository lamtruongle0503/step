# == Schema Information
#
# Table name: product_area_settings
#
#  id              :bigint           not null, primary key
#  price           :float
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  area_setting_id :bigint
#  product_id      :bigint
#
# Indexes
#
#  index_product_area_settings_on_area_setting_id  (area_setting_id)
#  index_product_area_settings_on_product_id       (product_id)
#
# Foreign Keys
#
#  fk_rails_...  (area_setting_id => area_settings.id)
#  fk_rails_...  (product_id => products.id)
#
class ProductAreaSetting < ApplicationRecord
  belongs_to :product
  belongs_to :area_setting
end
