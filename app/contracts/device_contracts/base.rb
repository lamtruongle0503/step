# frozen_string_literal: true

class DeviceContracts::Base < ApplicationContract
  attribute :os, String
  attribute :device_token, String

  validates :os, :device_token, presence: true
end
