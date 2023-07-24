# frozen_string_literal: true

class Api::V1::Users::ChangePasswordsController < ApiV1Controller
  before_action :authentication!

  def update
    render json: Api::UserOperations::ChangePasswordOperations::Update.new(actor, params).call,
           serializer: Api::Users::ChangePasswords::UpdateSerializer, root: 'users'
  end
end
