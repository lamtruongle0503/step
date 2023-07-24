# frozen_string_literal: true

class AuthContracts::AdminContracts::Create < AuthContracts::Base
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze

  validates :email, presence: true, format: { with: EMAIL_REGEX }
end
