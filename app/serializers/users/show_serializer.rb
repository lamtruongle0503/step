# frozen_string_literal: true

class Users::ShowSerializer < ApplicationSerializer
  attribute :user
  attribute :credits_card
  attribute :asset_image

  def user
    Users::AttributesSerializer.new(object[:user]).as_json
  end

  def credits_card
    object[:credits_card]
  end

  def asset_image
    object[:user].asset ? Assets::AttributesSerializer.new(object[:user].asset) : []
  end
end
