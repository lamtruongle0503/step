# frozen_string_literal: true

class EcommerceContracts::OrderInfoContracts::Base < ApplicationContract
  attribute :order_id,            Integer
  attribute :delivery_date,       Date
  attribute :delivery_start_time, Time
  attribute :delivery_end_time,   Time
  attribute :content,             String
  attribute :address_id,          Integer

  # validates :delivery_date, presence: true
  # validates :delivery_start_time, presence: true
  # validates :delivery_end_time, presence: true
  # validates :address_id, existence: Address.name
end
