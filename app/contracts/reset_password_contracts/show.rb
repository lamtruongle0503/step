# frozen_string_literal: true

class ResetPasswordContracts::Show < ApplicationContract
  attribute :verify_code, String
  attribute :record, User

  validates :verify_code, presence: true, numericality: { only_integer: true }
  validate :invalid_token!, :verify_code_expired!

  private

  def invalid_token!
    user_verify_code = record.verify_code
    errors.add :verify_code, I18n.t('reset_password.invalid_verify_code') if user_verify_code != verify_code
  end

  def verify_code_expired!
    errors.add :verify_code, I18n.t('reset_password.verify_code_expired') if code_expired?
  end

  def code_expired?
    Time.zone.now > record.expired_at
  end
end
