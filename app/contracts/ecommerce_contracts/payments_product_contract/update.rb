# frozen_string_literal: true

class EcommerceContracts::PaymentsProductContract::Update < EcommerceContracts::PaymentsProductContract::Base
  attribute :id,         Integer
  attribute :_destroy,   String
  attribute :product_id, Integer

  validates :payment_id, existence: Payment.name, if: -> { id.blank? }
end
