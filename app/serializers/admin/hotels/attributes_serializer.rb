# frozen_string_literal: true

class Admin::Hotels::AttributesSerializer < ApplicationSerializer
  attributes :id, :name, :email, :yomigana, :postal_code, :telephone, :web_comm_fee,
             :address1, :address2, :manager, :contact_info, :representative,
             :status, :area_setting_id, :fax_number, :opening_date,
             :refurbished_date, :room_total, :manager_info, :reservation_comm_fee,
             :purchased_fee, :credit_settlement_fee, :pr_desc, :access_desc,
             :parking_desc, :feature_options, :amenity_options,
             :tax_service, :tax_information, :children_information, :pet_information,
             :other_information, :payment_options, :check_in, :check_out, :accommodation_tax_rate,
             :allow_children, :allow_pet, :created_at, :updated_at
  belongs_to :hotel_category, serializer: Admin::Hotels::Categories::AttributesSerializer
  belongs_to :prefecture, serializer: Prefectures::AttributesSerializer
  belongs_to :area_setting, serializer: Admin::AreaSettings::AttributesSerializer
  has_many :coupons, serializer: Admin::Coupons::AttributesSerializer
end
