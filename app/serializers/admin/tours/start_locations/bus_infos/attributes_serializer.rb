# frozen_string_literal: true

class Admin::Tours::StartLocations::BusInfos::AttributesSerializer < ApplicationSerializer
  attributes :id, :name, :concentrate_time, :depature_time, :address, :setting_date,
             :is_setting, :code, :tour_place_start_id
end
