# == Schema Information
#
# Table name: area_settings
#
#  id         :bigint           not null, primary key
#  code       :string
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class AreaSetting < ApplicationRecord
  has_many :product_area_settings, dependent: :destroy
  has_many :prefectures, dependent: :destroy
  has_many :hotels, dependent: :destroy
end
