# frozen_string_literal: true

class UserContactContracts::AdminContracts::Base < ApplicationContract
  attribute :email,            String
  attribute :password,         String
  attribute :phone_number,     String
  attribute :first_name,       String
  attribute :last_name,        String
  attribute :first_name_kana,  String
  attribute :last_name_kana,   String
  attribute :gender,           Integer
  attribute :birth_day,        DateTime
  attribute :address1,         String
  attribute :address2,         String
  attribute :verify_code,      String
  attribute :expired_at,       DateTime
  attribute :password_confirm, String
  attribute :note,             String
  attribute :is_dm,            Boolean
  attribute :nick_name,        String
  attribute :status,           String
  attribute :code,             String
  attribute :full_name,        String
  attribute :furigana,         String

  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  PHONE_REGEX = /\A(?:\+?\d{1,3}\s*-?)?\(?(?:\d{3})?\)?[- ]?\d{3}[- ]?\d{4}\z/.freeze

  validates :email, format: { with: EMAIL_REGEX }, if: -> { email.present? }
  validates :gender, presence: true, inclusion: { in: UserContact.genders.keys }

  validates :birth_day, presence:   true,
                           timeliness: {
                             on_or_before:         -> { Date.current },
                             type:                 :date,
                             on_or_before_message: I18n.t('.must_be_before_today'),
                           }, if: -> { birth_day.present? }
end
