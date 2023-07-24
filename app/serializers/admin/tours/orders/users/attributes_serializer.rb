# frozen_string_literal: true

class Admin::Tours::Orders::Users::AttributesSerializer < ApplicationSerializer
  attributes %i[id full_name gender birth_day email phone_number telephone post_code
                addresses code point]

  def full_name
    "#{object.first_name}　#{object.last_name}"
  end

  def addresses
    object.addresses
  end

  def point
    object.point.to_i + object.point_bonus.to_i
  end
end
