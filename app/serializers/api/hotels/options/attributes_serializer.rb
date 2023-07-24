# frozen_string_literal: true

class Api::Hotels::Options::AttributesSerializer < ApplicationSerializer
  attributes :id, :management_name, :name, :price, :is_use, :description, :unit
  has_many :assets, serializer: Assets::AttributesSerializer
end
