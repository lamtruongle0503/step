# frozen_string_literal: true

class Api::Tours::Stays::Options::AttributeSerializer < ApplicationSerializer
  attributes :id, :name, :code, :is_free, :price
end
