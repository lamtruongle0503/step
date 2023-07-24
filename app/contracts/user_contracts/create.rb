# frozen_string_literal: true

class UserContracts::Create < UserContracts::Base
  validates :phone_number, presence:     true,
                           format:       { with: PHONE_REGEX },
                           uniqueness:   { model: User },
                           numericality: true
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
