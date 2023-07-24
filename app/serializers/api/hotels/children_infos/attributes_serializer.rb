# frozen_string_literal: true

class Api::Hotels::ChildrenInfos::AttributesSerializer < ApplicationSerializer
  attributes :id, :name, :fee, :unit, :capacity, :is_accept, :code
end
