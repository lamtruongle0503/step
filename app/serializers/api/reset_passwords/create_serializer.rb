# frozen_string_literal: true

class Api::ResetPasswords::CreateSerializer < ApplicationSerializer
  attribute :messages

  def messages
    I18n.t('reset_password.sent_verify_code')
  end
end
