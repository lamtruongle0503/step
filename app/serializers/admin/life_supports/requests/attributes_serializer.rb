# frozen_string_literal: true

class Admin::LifeSupports::Requests::AttributesSerializer < ApplicationSerializer
  attributes :id, :name, :postal_code, :address1, :address2, :phone_number, :status

  belongs_to :life_support, serializer: Admin::LifeSupports::AttributesSerializer
end
