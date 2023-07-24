# frozen_string_literal: true

class Admin::Hotels::Rooms::AttributesSerializer < ApplicationSerializer
  attributes :id, :name, :management_name, :room_type, :is_show, :floor_type, :capacity, :square_meter_max,
             :square_meter_min, :description, :floor_number, :is_smoking, :number_children, :floor_plan,
             :total_floor_min, :total_floor_max
end
