# frozen_string_literal: true

class Api::Tours::TourSpecialFoods::AttributesSerializer < ApplicationSerializer
  attributes :id, :is_free, :name, :price, :assets

  has_many :assets, serializer: Assets::AttributesSerializer

  def price
    object.is_free.present? ? 0 : object.price
  end
end
