# frozen_string_literal: true

class HotelContracts::Base < ApplicationContract
  attribute :name, String
  attribute :email, String
  attribute :yomigana, String
  attribute :postal_code, String
  attribute :telephone, String
  attribute :web_comm_fee, Float
  attribute :address1, String
  attribute :address2, String
  attribute :manager, String
  attribute :contact_info, String
  attribute :representative, String
  attribute :status, Integer
  attribute :prefecture_id, Integer
  attribute :area_setting_id, Integer
  attribute :hotel_category_id, Integer
  attribute :fax_number, String
  attribute :opening_date, Date
  attribute :refurbished_date, Date
  attribute :room_total, Integer
  attribute :manager_info, String
  attribute :reservation_comm_fee, Float
  attribute :purchased_fee, Float
  attribute :credit_settlement_fee, Float
  attribute :pr_desc, String
  attribute :access_desc, String
  attribute :parking_desc, String
  attribute :feature_options, String
  attribute :amenity_options, String
  attribute :tax_service, Integer
  attribute :tax_information, String
  attribute :allow_children, Integer
  attribute :children_information, String
  attribute :allow_pet, Integer
  attribute :pet_information, String
  attribute :other_information, String
  attribute :payment_options, String
  attribute :check_in, String
  attribute :check_out, String
  attribute :accommodation_tax_rate, Integer

  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze

  validates :status, inclusion: { in: (0..1) }, if: -> { status }
  validates :prefecture_id, presence: true, existence: Prefecture.name
  validates :area_setting_id, presence: true, existence: AreaSetting.name
  validates :hotel_category_id, existence: Hotel::Category.name, if: -> { hotel_category_id }
  validates :allow_children, inclusion: { in: Hotel.allow_children }, if: -> { allow_children }
  validates :allow_pet, inclusion: { in: Hotel.allow_pets }, if: -> { allow_pet }
  validates :fax_number, presence: true
  validates :tax_service, inclusion: { in: Hotel.tax_services }, if: -> { tax_service }
  validates :room_total, length: { maximum: 15 }, if: -> { room_total }
  validates :email, format: { with: EMAIL_REGEX }

  with_options numericality: { only_integer: true } do
    validates :telephone, format: { with: Hotel::PHONE_REGEX }, if: -> { telephone }
    validates :postal_code, if: -> { postal_code }
  end

  with_options length: { maximum: 255 } do
    validates :name, presence: true, if: -> { name }
    validates :yomigana, if: -> { yomigana }
  end

  with_options numericality: { only_float: true }, inclusion: { in: (0..100) } do
    validates :purchased_fee, if: -> { purchased_fee }
    validates :web_comm_fee, if: -> { web_comm_fee }
    validates :reservation_comm_fee, if: -> { reservation_comm_fee }
    validates :credit_settlement_fee, if: -> { credit_settlement_fee }
  end
end
