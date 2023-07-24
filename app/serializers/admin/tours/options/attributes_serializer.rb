# frozen_string_literal: true

class Admin::Tours::Options::AttributesSerializer < ApplicationSerializer
  attributes :id, :name, :code, :price, :is_free, :file, :deleted_at

  def file
    object.assets.map do |asset|
      Assets::AttributesSerializer.new(asset).as_json
    end
  end
end
