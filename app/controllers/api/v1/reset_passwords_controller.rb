# frozen_string_literal: true

class Api::V1::ResetPasswordsController < ApiV1Controller
  def create
    render json: Api::ResetPasswordOperations::Create.new(nil, params).call,
           serializer: Api::ResetPasswords::CreateSerializer, root: 'reset_passwords'
  end

  def update
    render json: Api::ResetPasswordOperations::Update.new(nil, params).call,
           serializer: Users::AttributesSerializer, root: 'user'
  end

  def verify
    render json: Api::ResetPasswordOperations::Verify.new(nil, params).call,
           serializer: Api::ResetPasswords::ShowSerializer, root: 'reset_passwords'
  end
end
