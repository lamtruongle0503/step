# == Schema Information
#
# Table name: notifications
#
#  id             :bigint           not null, primary key
#  deleted_at     :datetime
#  description    :text
#  gender         :integer
#  is_gender      :boolean          default(FALSE)
#  is_prefecture  :boolean          default(FALSE)
#  is_resend      :boolean          default(FALSE)
#  module_type    :string
#  month_birthday :text             default([]), is an Array
#  send_all       :boolean
#  title          :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  module_id      :bigint
#
# Indexes
#
#  index_notifications_on_module  (module_type,module_id)
#
class Notification < ApplicationRecord
  acts_as_paranoid

  enum gender: { male: 0, female: 1, other: 2 }

  belongs_to :module, polymorphic: true, optional: true
  belongs_to :coupon, foreign_key: :module_id, optional: true
  belongs_to :tour, foreign_key: :module_id, optional: true
  has_one :assets_module, as: :module, dependent: :destroy
  has_one :asset, through: :assets_module
  has_many :notifications_prefectures, dependent: :destroy
  has_many :prefectures, through: :notifications_prefectures
  has_many :users_notifications, dependent: :destroy
  belongs_to :point_usage, class_name: PointUsage.name, foreign_key: :module_id, optional: true
end
