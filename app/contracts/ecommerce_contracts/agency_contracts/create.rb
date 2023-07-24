# frozen_string_literal: true

class EcommerceContracts::AgencyContracts::Create < EcommerceContracts::AgencyContracts::Base
  validates :code, presence: true, uniqueness: { model: Agency }
end
