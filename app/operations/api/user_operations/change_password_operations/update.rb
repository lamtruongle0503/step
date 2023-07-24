# frozen_string_literal: true

class Api::UserOperations::ChangePasswordOperations::Update < ApplicationOperation
  attr_reader :user, :current_password

  def initialize(actor, params)
    super
    @user = actor
    @current_password = params[:current_password]
  end

  def call
    UserContracts::ChangePasswordContracts::Update.new(
      change_password_params.merge!(record: actor, current_password: current_password),
    ).valid!
    user.update!(password: params[:password])
  end

  private

  def change_password_params
    params.permit(:password, :password_confirmation)
  end
end
