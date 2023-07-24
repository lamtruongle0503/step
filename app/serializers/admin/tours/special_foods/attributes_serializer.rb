# frozen_string_literal: true

class Admin::Tours::SpecialFoods::AttributesSerializer < ApplicationSerializer
  attributes :id, :name, :is_free, :code, :price, :file
  def file
    object.assets.map do |asset|
      Assets::AttributesSerializer.new(asset).as_json
    end
  end
end
