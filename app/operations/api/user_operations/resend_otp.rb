# frozen_string_literal: true

class Api::UserOperations::ResendOtp < ApplicationOperation
  attr_reader :user, :otp

  def initialize(actor, params)
    super
    @otp = verify_code
    @user = User.find_by!(phone_number: params[:phone_number])
  end

  def call
    UserContracts::ResendOtp.new(phone_number: params[:phone_number]).valid!
    ActiveRecord::Base.transaction do
      user.update!(verify_code: otp, expired_at: Time.zone.now + 15.minutes)
      send_sms(otp)
      user
    end
  end

  private

  def verify_code
    Random.rand(100_000...999_999)
  end

  def send_sms(otp)
    client = AwsSqsService.new
    client.send('SMS', '', I18n.t('verify.verify_messages', verify_code: otp),
                params[:phone_number])
  end
end
