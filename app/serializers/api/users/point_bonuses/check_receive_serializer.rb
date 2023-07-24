# frozen_string_literal: true

class Api::Users::PointBonuses::CheckReceiveSerializer < ApplicationSerializer
  attributes :is_expried

  def is_expried # rubocop:disable Naming/PredicateName
    object[:is_expried]
  end
end
