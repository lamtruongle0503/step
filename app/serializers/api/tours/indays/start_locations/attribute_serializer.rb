# frozen_string_literal: true

class Api::Tours::Indays::StartLocations::AttributeSerializer < ApplicationSerializer
  attributes :id, :name, :address, :concentrate_time, :depature_time, :setting_date,
             :is_setting, :code
end
