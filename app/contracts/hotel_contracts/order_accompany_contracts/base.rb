# frozen_string_literal: true

class HotelContracts::OrderAccompanyContracts::Base < ApplicationContract
  attribute :is_owner, Boolean
  attribute :first_name, String
  attribute :last_name, String
  attribute :first_name_kana, String
  attribute :last_name_kana, String
  attribute :gender, Integer
  attribute :postal_code, String
  attribute :phone_number, String
  attribute :telephone, String
  attribute :address1, String
  attribute :address2, String
  attribute :email, String
  attribute :birth_day, String

  PHONE_REGEX = /\A(?:\+?\d{1,3}\s*-?)?\(?(?:\d{3})?\)?[- ]?\d{3}[- ]?\d{4}\z/.freeze
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze

  with_options presence: true do
    validates :first_name
    validates :last_name
    validates :first_name_kana
    validates :last_name_kana
    validates :phone_number, format: { with: PHONE_REGEX }, numericality: { only_integer: true }
  end

  validates :telephone, numericality: { only_integer: true }, if: -> { telephone.present? }
  validates :email, format: { with: EMAIL_REGEX }, if: -> { email.present? }
end
