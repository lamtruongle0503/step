# frozen_string_literal: true

class Admin::AuthsController < ApiV1Controller
  def create
    render json: Admin::AuthOperations::Create.new(nil, params).call,
           serializer: Auths::CreateSerializer, root: 'auths'
  end
end
