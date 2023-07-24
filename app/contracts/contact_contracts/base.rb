# frozen_string_literal: true

class ContactContracts::Base < ApplicationContract
  attribute :email,               String
  attribute :phone_number,        String
  attribute :contents,            String
  attribute :user,                String
  attribute :created_at,          Date
  attribute :contact_category_id, Integer
  attribute :status,              String
  attribute :furigana,            String
  attribute :todo,                String
  attribute :code,                String

  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  PHONE_REGEX = /\A(?:\+?\d{1,3}\s*-?)?\(?(?:\d{3})?\)?[- ]?\d{3}[- ]?\d{4}\z/.freeze

  validates :email, format: { with: EMAIL_REGEX }, if: -> { email.present? }
  validates :phone_number, format: { with: PHONE_REGEX }, numericality: true, if: -> { phone_number.present? }
  validates :contact_category_id, existence: ContactCategory.name, if: -> { contact_category_id }
  validates :status, presence: true, inclusion: { in: Contact.statuses }, if: -> { status }
  validates :code, uniqueness: { model: Contact }, if: -> { code.present? }
end
