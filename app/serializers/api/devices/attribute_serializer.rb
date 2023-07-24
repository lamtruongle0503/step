# frozen_string_literal: true

class Api::Devices::AttributeSerializer < ApplicationSerializer
  attributes :id, :device_token
end
