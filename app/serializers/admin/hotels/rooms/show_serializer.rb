# frozen_string_literal: true

class Admin::Hotels::Rooms::ShowSerializer < Admin::Hotels::Rooms::AttributesSerializer
  attributes :is_smoking, :floor_plan, :floor_type, :setting_date, :square_meter_max, :square_meter_min,
             :capacity, :description, :created_at, :updated_at
  has_many :assets, serializer: Assets::AttributesSerializer

  def created_at
    return unless object.created_at

    object.created_at.to_date
  end

  def updated_at
    return unless object.updated_at

    object.updated_at.to_date
  end
end
