# frozen_string_literal: true

class Api::Hotels::Rooms::AttributesSerializer < ApplicationSerializer
  attributes :id, :name, :setting_date, :management_name, :room_type,
             :floor_number, :description, :capacity, :floor_plan, :is_smoking, :is_show,
             :floor_type, :square_meter_max, :square_meter_min, :total_floor_max, :total_floor_min,
             :number_children, :assets

  def assets
    object.assets.map do |asset|
      Assets::AttributesSerializer.new(asset).as_json
    end
  end
end
