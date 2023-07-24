# frozen_string_literal: true

class EcommerceContracts::AgencyContracts::Base < ApplicationContract
  attribute :name,            String
  attribute :email,           String
  attribute :code,            String
  attribute :address,         String
  attribute :contact_address, String
  attribute :person,          String
  attribute :company_name,    String
  attribute :is_free,         Boolean
  attribute :fee_shipping,    Integer
  attribute :payment_ids,     Array
  attribute :delivery_ids,    Array

  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze

  validates :name, presence: true
  validates :address, presence: true
  validates :contact_address, presence: true
  validates :person, presence: true
  validates :company_name, presence: true
  validates :fee_shipping, presence:     true,
                           numericality: { greater_than: 0 },
                           length:       { maximum: 15 },
                           if:           -> { is_free }
  validates :email, presence: true, format: { with: EMAIL_REGEX }
  validates :payment_ids, existences: Payment.name, if: -> { payment_ids.present? }
  validates :delivery_ids, existences: Delivery.name, if: -> { delivery_ids.present? }
end
