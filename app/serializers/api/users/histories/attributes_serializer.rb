# frozen_string_literal: true

class Api::Users::Histories::AttributesSerializer < ApplicationSerializer
  attributes %i[id full_name gender email phone_number]

  def full_name
    "#{object.first_name}　#{object.last_name}"
  end
end
