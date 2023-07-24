# frozen_string_literal: true

class Api::AdminSettings::AttributesSerializer < ApplicationSerializer
  attributes :id, :key, :value
end
