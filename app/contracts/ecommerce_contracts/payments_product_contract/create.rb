# frozen_string_literal: true

class EcommerceContracts::PaymentsProductContract::Create < EcommerceContracts::PaymentsProductContract::Base
  validates :payment_id, existence: Payment.name
end
