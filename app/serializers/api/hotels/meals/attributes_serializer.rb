# frozen_string_literal: true

class Api::Hotels::Meals::AttributesSerializer < ApplicationSerializer
  attributes :id, :management_name, :name, :type, :description, :address, :start_time, :end_time
  has_many :assets, serializer: Assets::AttributesSerializer
end
