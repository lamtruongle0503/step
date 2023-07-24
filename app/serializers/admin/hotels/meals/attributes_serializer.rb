# frozen_string_literal: true

class Admin::Hotels::Meals::AttributesSerializer < ApplicationSerializer
  attributes :id, :is_used, :management_name, :name, :type, :address
end
