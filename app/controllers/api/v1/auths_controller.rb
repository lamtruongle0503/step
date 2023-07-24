# frozen_string_literal: true

class Api::V1::AuthsController < ApiV1Controller
  def create
    render json: Api::AuthOperations::Create.new(nil, params).call,
           serializer: Auths::CreateSerializer, root: 'auths'
  end
end
