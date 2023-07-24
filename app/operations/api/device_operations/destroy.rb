# frozen_string_literal: true

class Api::DeviceOperations::Destroy < ApplicationOperation
  def call
    device_token = Device.find_by(device_token: params[:id])
    device_token&.destroy
  end
end
