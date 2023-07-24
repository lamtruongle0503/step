# frozen_string_literal: true

class EcommerceContracts::OrderProductContracts::Create < EcommerceContracts::OrderProductContracts::Base
  validates :number, presence: true, numericality: { greater_than: 0 }
end
