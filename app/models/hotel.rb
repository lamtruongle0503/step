# == Schema Information
#
# Table name: hotels
#
#  id                           :bigint           not null, primary key
#  access_desc                  :string
#  accommodation_tax_rate       :integer
#  address1                     :string
#  address2                     :string
#  allow_children               :integer
#  allow_pet                    :integer
#  amenity_options              :jsonb
#  check_in                     :string
#  check_out                    :string
#  children_information         :string
#  contact_info                 :string
#  credit_settlement_fee        :float
#  deleted_at                   :datetime
#  email                        :string
#  fax_number                   :string
#  feature_options              :jsonb
#  manager                      :string
#  manager_info                 :string
#  name                         :string           not null
#  opening_date                 :date
#  other_information            :string
#  parking_desc                 :string
#  payment_options              :jsonb
#  pet_information              :string
#  postal_code                  :string
#  pr_desc                      :string
#  purchased_fee                :float
#  refurbished_date             :date
#  representative               :string
#  reservation_comm_fee         :float
#  room_total                   :bigint
#  status                       :integer          default("posting")
#  tax_information              :string
#  tax_service                  :integer          default("consumption_tax_and_service_fee")
#  telephone                    :string
#  web_comm_fee                 :float
#  yomigana                     :string
#  created_at                   :datetime         not null
#  updated_at                   :datetime         not null
#  area_setting_id              :integer
#  hotel_cancellation_policy_id :bigint
#  hotel_category_id            :integer
#  prefecture_id                :integer
#
# Indexes
#
#  index_hotels_on_hotel_cancellation_policy_id  (hotel_cancellation_policy_id)
#
class Hotel < ApplicationRecord
  acts_as_paranoid

  belongs_to :prefecture, foreign_key: :prefecture_id
  belongs_to :hotel_category, foreign_key: :hotel_category_id, class_name: 'Hotel::Category'
  belongs_to :area_setting, foreign_key: :area_setting_id
  has_many :coupons_modules, as: :module, dependent: :destroy
  has_many :coupons, through: :coupons_modules
  has_many :assets_modules, as: :module, dependent: :destroy
  has_many :assets, through: :assets_modules
  has_many :hotel_meals, dependent: :destroy, class_name: 'Hotel::Meal'
  has_many :hotel_cancellation_policies, class_name: 'Hotel::CancellationPolicy', dependent: :destroy
  has_many :hotel_options, dependent: :destroy, class_name: 'Hotel::Option'
  has_many :hotel_plans, dependent: :destroy, class_name: 'Hotel::Plan'
  has_many :hotel_rooms, dependent: :destroy, class_name: 'Hotel::Room'
  has_many :hotel_room_settings, through: :hotel_rooms
  has_many :hotel_children_infos, dependent: :destroy, class_name: 'Hotel::ChildrenInfo'
  has_many :hotel_orders, dependent: :destroy, class_name: 'Hotel::Order'
  has_many :hotel_requests, dependent: :destroy, class_name: 'Hotel::Request'

  PHONE_REGEX = /\A(?:\+?\d{1,3}\s*-?)?\(?(?:\d{3})?\)?[- ]?\d{3}[- ]?\d{4}\z/.freeze

  CHILD_NO_AVAILABLE = 'child_no_available'.freeze
  CHILD_AVAILABLE    = 'child_available'.freeze
  PET_NO_AVAILABLE = 'pet_no_available'.freeze
  PET_AVAILABLE    = 'pet_available'.freeze
  CONSUMPTION_TAX_AND_SERVICE_FEE = 'consumption_tax_and_service_fee'.freeze
  CONSUMPTION_TAX_AND_NO_SERVICE_FEE = 'consumption_tax_and_no_service_fee'.freeze
  NO_CONSUMPTION_TAX_AND_SERVICE_FEE = 'no_consumption_tax_and_service_fee'.freeze
  POSTING   = 'posting'.freeze
  ENDED     = 'ended'.freeze

  enum allow_children: { child_no_available: 0, child_available: 1 }
  enum allow_pet: { pet_no_available: 0, pet_available: 1 }
  enum tax_service: { consumption_tax_and_service_fee: 0, consumption_tax_and_no_service_fee: 1,
                      no_consumption_tax_and_service_fee: 2 }
  enum status: { posting: 0, ended: 1 }

  scope :posting, -> { where(status: Hotel::POSTING) }

  scope :ranking, lambda {
    joins('LEFT JOIN hotel_orders ON hotels.id = hotel_orders.hotel_id')
      .where(status: Hotel::POSTING)
      .group('hotels.id')
      .order('count(hotel_orders.hotel_id) desc, created_at desc')
  }

  ransacker :title do
    Arel.sql 'pr_desc'
  end
end
