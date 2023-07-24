# frozen_string_literal: true

class Api::DeviceOperations::Create < ApplicationOperation
  def call
    DeviceContracts::Create.new(device_params).valid!
    create_device!
  end

  private

  def create_device!
    Device.create!(device_params.merge(user_id: actor.id))
  end

  def device_params
    params.permit(:os, :device_token)
  end
end
