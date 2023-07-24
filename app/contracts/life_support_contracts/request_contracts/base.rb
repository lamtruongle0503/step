# frozen_string_literal: true

class LifeSupportContracts::RequestContracts::Base < ApplicationContract
  attribute :name,            String
  attribute :postal_code,     String
  attribute :address1,        String
  attribute :address2,        String
  attribute :phone_number,    String

  PHONE_REGEX = /\A(?:\+?\d{1,3}\s*-?)?\(?(?:\d{3})?\)?[- ]?\d{3}[- ]?\d{4}\z/.freeze

  validates :name, presence: true
  validates :postal_code, presence: true
  validates :address1, presence: true
  validates :address2, presence: true

  with_options numericality: { only_integer: true } do
    validates :postal_code, presence: true
    validates :phone_number, format: { with: PHONE_REGEX }
  end
end
