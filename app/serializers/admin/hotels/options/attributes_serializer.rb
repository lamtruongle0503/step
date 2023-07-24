# frozen_string_literal: true

class Admin::Hotels::Options::AttributesSerializer < ApplicationSerializer
  attributes :id, :name, :management_name, :price, :unit, :is_use
end
