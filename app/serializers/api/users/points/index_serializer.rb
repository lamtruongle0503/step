# frozen_string_literal: true

class Api::Users::Points::IndexSerializer < ApplicationSerializer
  attribute :point

  def point
    object[:point]
  end
end
