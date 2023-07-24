# == Schema Information
#
# Table name: banners
#
#  id           :bigint           not null, primary key
#  company_name :string
#  content      :text
#  deleted_at   :datetime
#  email        :string
#  end_date     :date
#  is_show      :boolean          default(TRUE)
#  option       :integer          default("phone")
#  start_date   :date
#  telephone    :string
#  title        :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class Banner < ApplicationRecord
  acts_as_paranoid

  has_many :banner_prefectures, dependent: :destroy
  has_many :banner_requests, dependent: :destroy, class_name: 'Banner::Request'
  has_many :prefectures, through: :banner_prefectures
  has_many :assets_modules, as: :module, dependent: :destroy
  has_many :assets, through: :assets_modules

  PHONE = 'phone'.freeze
  FILE  = 'file'.freeze
  ALL   = 'together'.freeze

  enum option: { phone: 1, file: 2, together: 3 }

  scope :setting_show, -> { where(is_show: true) }
  scope :available, lambda {
    where('end_date >= ? AND start_date <= ?', Date.current, Date.current)
  }
end
