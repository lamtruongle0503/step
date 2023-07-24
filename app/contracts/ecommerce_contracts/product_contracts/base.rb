# frozen_string_literal: true

class EcommerceContracts::ProductContracts::Base < ApplicationContract
  attribute :category_id,                       Integer
  attribute :code,                              String
  attribute :name,                              String
  attribute :description,                       String
  attribute :discount,                          Float
  attribute :is_discount,                       Boolean
  attribute :colors,                            String
  attribute :remaining_count,                   Integer
  attribute :description_info,                  String
  attribute :brand,                             String
  attribute :original_country,                  String
  attribute :distributor,                       String
  attribute :precaution,                        String
  attribute :desired_delivery_date,             Integer
  attribute :hash_tag,                          String
  attribute :is_show,                           Boolean
  attribute :is_limit,                          Boolean
  attribute :exp_date,                          DateTime
  attribute :is_delivery_free,                  Boolean
  attribute :is_desired_date_free,              Boolean
  attribute :is_desired_time_free,              Boolean
  attribute :agency_id,                         Integer
  attribute :tax,                               Integer

  attribute :product_sizes_attributes,          Array
  attribute :delivery_time_settings_attributes, Array
  attribute :product_area_settings_attributes,  Array

  validates :category_id, presence: true, existence: Category.name
  validates :agency_id, presence: true, existence: Agency.name
  validates :name, :tax, presence: true
  validates :description, presence: true
  validates :remaining_count, numericality: { only_integer: true }, if: -> { is_limit }
  validates :delivery_time_settings_attributes, presence: true, unless: -> { is_desired_time_free }
  validates :product_area_settings_attributes, presence: true, unless: -> { is_delivery_free }
  validates :is_delivery_free, :is_limit, :is_desired_date_free, :is_desired_time_free,
            inclusion: { in: [true, false] }
  validates :desired_delivery_date, numericality: { only_integer: true },
                                    length:       { maximum: 15 },
                                    if:           lambda {
                                                    !is_desired_date_free && desired_delivery_date.present?
                                                  }
  validate :delivery_time_settings, unless: -> { is_desired_time_free }

  validate :product_sizes,
           :product_area_settings
end
