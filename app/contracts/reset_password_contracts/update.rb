# frozen_string_literal: true

class ResetPasswordContracts::Update < ApplicationContract
  attribute :password, String
  attribute :password_confirmation, String

  validates :password, presence:     true,
                       length:       {
                         minimum: 6,
                         maximum: 16,
                       },
                       confirmation: true

  validates :password_confirmation, presence: true,
                                    length:   {
                                      minimum: 6,
                                      maximum: 16,
                                    }
end
