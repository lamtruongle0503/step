# == Schema Information
#
# Table name: hotel_options
#
#  id              :bigint           not null, primary key
#  deleted_at      :datetime
#  description     :string
#  is_use          :boolean          default(FALSE)
#  management_name :string
#  name            :string
#  price           :float
#  unit            :integer          default("percent")
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  hotel_id        :bigint
#
# Indexes
#
#  index_hotel_options_on_hotel_id  (hotel_id)
#
# Foreign Keys
#
#  fk_rails_...  (hotel_id => hotels.id)
#
class Hotel::Option < ApplicationRecord
  acts_as_paranoid

  belongs_to :hotel, foreign_key: :hotel_id
  has_many :assets_modules, as: :module, dependent: :destroy
  has_many :assets, through: :assets_modules
  has_many :hotel_plan_options, foreign_key: :hotel_plan_id, dependent: :destroy,
           class_name: 'Hotel::PlanOption'

  PERCENT = 'percent'.freeze
  JPY = 'jpy'.freeze
  enum unit: { percent: 1, jpy: 2 }

  scope :use, -> { where(is_use: true) }
end
