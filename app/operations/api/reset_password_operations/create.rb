# frozen_string_literal: true

class Api::ResetPasswordOperations::Create < ApplicationOperation
  attr_reader :user, :otp

  def call
    @otp = verify_code
    ResetPasswordContracts::Create.new(phone_number: params[:phone_number]).valid!
    @user = User.find_by!(phone_number: params[:phone_number])
    user.update!(verify_code: otp, expired_at: Time.zone.now + 15.minutes)
    send_sms(otp)
  end

  private

  def verify_code
    Random.rand(100_000...999_999)
  end

  def send_sms(otp)
    client = AwsSqsService.new
    client.send('SMS', '', I18n.t('reset_password.verify_messages', verify_code: otp),
                user.phone_number)
  end

  def reset_password_params
    params.permit(
      :password,
      :password_confirmation,
    )
  end
end
