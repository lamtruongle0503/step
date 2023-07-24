# frozen_string_literal: true

class Admin::Tours::Managements::StartLocations::AttributesSerializer < ApplicationSerializer
  attributes :id, :name, :address, :concentrate_time, :depature_time, :setting_date,
             :is_setting
end
