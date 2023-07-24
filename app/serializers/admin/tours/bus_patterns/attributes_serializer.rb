# frozen_string_literal: true

class Admin::Tours::BusPatterns::AttributesSerializer < ApplicationSerializer
  attributes :id, :name, :capacity, :map
end
