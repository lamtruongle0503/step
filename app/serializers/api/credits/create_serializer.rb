# frozen_string_literal: true

class Api::Credits::CreateSerializer < ApplicationSerializer
  attribute :card_id

  def card_id
    object[:card_id]
  end
end
