# frozen_string_literal: true

class Admin::Users::Meta::ShowSerializer < ApplicationSerializer
  attributes %i[id age gender birth_day post_code address1 address2
                email phone_number full_name furigana point]

  has_many :addresses, serializer: Admin::Addresses::AttributesSerializer

  def point
    object.point_bonus + object.point
  end
end
