# frozen_string_literal: true

class UserContracts::AddressContracts::Base < ApplicationContract
  attribute :full_name,  String
  attribute :postcode,   String
  attribute :address1,   String
  attribute :address2,   String
  attribute :telephone, String

  validates :postcode, :address1, :telephone, presence: true
end
