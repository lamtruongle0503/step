# frozen_string_literal: true

class Admin::AuthOperations::Create < ApplicationOperation
  attr_reader :email, :password, :admin, :auths_json

  def initialize(actor, params)
    super
    @email       = params[:email]
    @password    = params[:password]
    @admin       = Admin.find_by(email: email) || CompanyStaff.find_by(email: email)
    @auths_json  = {}
  end

  def call
    valid_admin_login
    access_token = generate_access_token(admin)
    auths_json.merge(access_token: access_token)
  end

  private

  def valid_admin_login
    AuthContracts::AdminContracts::Create.new(auth_params).valid!
    return if admin && password_verify?(admin)

    raise BadRequestError,
          email_password: I18n.t('auth.login_failure')
  end

  def password_verify?(admin)
    admin.authenticate(password)
  end

  def generate_access_token(admin)
    payload = Admin::Admins::AttributesSerializer.new(admin).as_json
    JsonWebToken.encode(payload.merge(server_time: Time.zone.now))
  end

  def auth_params
    params.permit(:email, :password)
  end
end
