# frozen_string_literal: true

class HotelContracts::RequestContracts::Base < ApplicationContract
  attribute :full_name, String
  attribute :phone_number, String
  attribute :email, String
  attribute :check_in, Date
  attribute :check_out, Date
  attribute :total_person, Integer
  attribute :total_room, Integer
  attribute :room_type, String
  attribute :comments, String

  PHONE_REGEX = /\A(?:\+?\d{1,3}\s*-?)?\(?(?:\d{3})?\)?[- ]?\d{3}[- ]?\d{4}\z/.freeze
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze

  with_options presence: true do
    validates :full_name
    validates :phone_number, format: { with: PHONE_REGEX }, numericality: { only_integer: true }
    validates :email, format: { with: EMAIL_REGEX }
    validates :check_in
    validates :check_out
    validates :total_person
  end

  validates :room_type, inclusion: { in: Hotel::Request.room_types }
end
