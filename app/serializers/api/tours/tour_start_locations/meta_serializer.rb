# frozen_string_literal: true

class Api::Tours::TourStartLocations::MetaSerializer < ApplicationSerializer
  attributes :id, :address, :concentrate_time, :depature_time, :name, :setting_date,
             :is_setting, :code
end
