# frozen_string_literal: true

class EcommerceContracts::AgencyContracts::Update < EcommerceContracts::AgencyContracts::Base
  attribute :record, Agency

  validates :code, presence: true, uniqueness: { model: Agency }, unless: -> { code_valid? }

  def code_valid?
    record.code == code
  end
end
