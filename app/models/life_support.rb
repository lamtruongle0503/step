# == Schema Information
#
# Table name: life_supports
#
#  id           :bigint           not null, primary key
#  company_name :string
#  content      :text
#  deleted_at   :datetime
#  email        :string
#  end_date     :date
#  option       :integer          default("phone")
#  start_date   :date
#  telephone    :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class LifeSupport < ApplicationRecord
  acts_as_paranoid
  has_many :life_support_prefectures, dependent: :destroy
  has_many :prefectures, through: :life_support_prefectures
  has_many :life_support_requests, dependent: :destroy, class_name: 'LifeSupport::Request'
  has_many :assets_modules, as: :module, dependent: :destroy
  has_many :assets, through: :assets_modules

  PHONE = 'phone'.freeze
  FILE  = 'file'.freeze
  ALL   = 'together'.freeze

  enum option: { phone: 1, file: 2, together: 3 }

  scope :available, lambda {
    where('end_date >= ? AND start_date <= ?', Date.current, Date.current)
  }
end
