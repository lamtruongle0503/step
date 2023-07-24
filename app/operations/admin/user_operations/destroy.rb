# frozen_string_literal: true

class Admin::UserOperations::Destroy < ApplicationOperation
  def call
    authorize User

    @user = User.find(params[:id])
    raise BadRequestError, password: I18n.t('errors.password_invalid') unless password_valid?

    @user.destroy!
  end

  private

  def password_valid?
    pwd_key = AdminSetting.find_by!(key: 'PWD_CONFIRM')
    pwd_key.authenticate(params[:password])
  end
end
