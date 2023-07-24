# frozen_string_literal: true

class Admin::Ecommerces::Agencies::AttributesSerializer < ApplicationSerializer
  attributes :id, :name, :code, :email, :address, :contact_address, :person, :is_free, :fee_shipping,
             :created_at, :company_name

  has_many :deliveries, serializer: Admin::Deliveries::IndexSerializer
  has_many :payments, serializer: Admin::Payments::IndexSerializer
end
