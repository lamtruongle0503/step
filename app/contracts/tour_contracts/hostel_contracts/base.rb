# frozen_string_literal: true

class TourContracts::HostelContracts::Base < ApplicationContract
  attribute :name,           String
  attribute :address1,       String
  attribute :address2,       String
  attribute :email,          String
  attribute :note,           String
  attribute :postal_code,    String
  attribute :telephone,      String
  attribute :description,    String

  PHONE_REGEX = /\A(?:\+?\d{1,3}\s*-?)?\(?(?:\d{3})?\)?[- ]?\d{3}[- ]?\d{4}\z/.freeze
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  validates :name, presence: true
  validates :telephone, presence: true, format: { with: PHONE_REGEX }, numericality: { only_integer: true }
  validates :email, format: { with: EMAIL_REGEX }, allow_blank: true, if: -> { email }
end
