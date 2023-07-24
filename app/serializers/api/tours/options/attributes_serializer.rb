# frozen_string_literal: true

class Api::Tours::Options::AttributesSerializer < ApplicationSerializer
  attributes :id, :name, :price, :is_free, :assets

  def assets
    object.assets.map do |asset|
      Assets::AttributesSerializer.new(asset).as_json
    end
  end

  def price
    object.is_free.present? ? 0 : object.price
  end
end
