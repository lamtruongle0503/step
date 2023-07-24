# frozen_string_literal: true

class Api::AuthOperations::Create < ApplicationOperation
  attr_reader :phone_number, :password, :user, :auths_json

  def initialize(actor, params)
    super
    @phone_number = params[:phone_number]
    @password     = params[:password]
    @user         = User.find_by(phone_number: phone_number)
    @auths_json   = {}
  end

  def call
    valid_user_login
    verify_user?
    access_token = generate_access_token(user)
    auths_json.merge(access_token: access_token)
  end

  private

  def valid_user_login
    AuthContracts::UserContracts::Create.new(auth_params).valid!

    raise BadRequestError, email_password: I18n.t('auth.login_failure') unless user && password_verify?(user)
  end

  def verify_user?
    return if user.is_verify

    raise BadRequestError, user_verify: I18n.t('auth.is_not_verify')
  end

  def password_verify?(user)
    user.authenticate(password)
  end

  def generate_access_token(user)
    payload = Users::AttributesSerializer.new(user).as_json
    JsonWebToken.encode(payload.merge(server_time: Time.zone.now))
  end

  def auth_params
    params.permit(:phone_number, :password)
  end
end
