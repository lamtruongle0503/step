# frozen_string_literal: true

class Api::UserOperations::Create < ApplicationOperation
  attr_reader :otp

  def call
    @otp = verify_code
    UserContracts::Create.new(user_params).valid!
    ActiveRecord::Base.transaction do
      user = create_user!
      create_user_prefecture!(user)
      create_user_address!(user) if params[:post_code].present?
      send_sms(otp)
      user.reload
    end
  end

  private

  def create_user!
    User.create!(user_params.merge(code:        generate_code(User.name),
                                   verify_code: otp,
                                   is_verify:   false,
                                   expired_at:  Time.zone.now + 15.minutes))
  end

  def create_user_prefecture!(user)
    user.create_user_prefecture(prefecture_id: Prefecture.first.id)
  end

  def create_user_address!(user)
    UserContracts::AddressContracts::Create.new(address_params).valid!
    user.addresses.create!(address_params)
  end

  def verify_code
    Random.rand(100_000...999_999)
  end

  def send_sms(otp)
    client = AwsSqsService.new
    client.send('SMS', '', I18n.t('verify.verify_messages', verify_code: otp),
                params[:phone_number])
  end

  def user_params
    params.permit(
      :email,
      :password,
      :password_confirmation,
      :phone_number,
      :first_name,
      :first_name_kana,
      :last_name,
      :last_name_kana,
      :gender,
      :birth_day,
      :post_code,
      :address1,
      :address2,
      :verify_code,
    )
  end

  def address_params
    {
      postcode:   params[:post_code],
      telephone:  params[:phone_number],
      full_name:  "#{params[:first_name]}　#{params[:last_name]}",
      address1:   params[:address1],
      address2:   params[:address2],
      is_default: true,
    }
  end
end
