# frozen_string_literal: true

class Admin::Tours::OrderSpecials::AttributesSerializer < ApplicationSerializer
  attributes :id, :name, :code, :description, :number_of_people, :capacity_pattern
end
