# frozen_string_literal: true

class Api::V1::DevicesController < ApiV1Controller
  before_action :authentication!

  def create
    render json: Api::DeviceOperations::Create.new(actor, params).call,
           serializer: Api::Devices::CreateSerializer, root: 'devices'
  end

  def destroy
    render json: Api::DeviceOperations::Destroy.new(actor, params).call,
           serializer: Api::Devices::DestroySerializer, root: 'devices'
  end
end
