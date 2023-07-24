# frozen_string_literal: true

class AuthContracts::Base < ApplicationContract
  attribute :phone_number, String
  attribute :password, String
  attribute :email, String

  validates :password, presence: true
end
