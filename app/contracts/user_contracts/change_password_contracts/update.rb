# frozen_string_literal: true

class UserContracts::ChangePasswordContracts::Update < ApplicationContract
  attribute :record, User
  attribute :current_password, String
  attribute :password, String
  attribute :password_confirmation

  validates :current_password, presence: true,
                               length:   {
                                 minimum: 6,
                                 maximum: 16,
                               }
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
  validate :current_password_invalid

  private

  def current_password_invalid
    return if record.authenticate(current_password)

    errors.add(:current_password,
               I18n.t('invalid.current_pasword'))
  end
end
