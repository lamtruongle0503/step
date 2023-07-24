# frozen_string_literal: true

class Api::Hotels::Plans::ShowSerializer < Api::Hotels::Plans::AttributesSerializer
  attributes :setting_limit_room, :from_room, :to_room, :allow_pet,
             :feature_options, :amenity_options, :options
  has_many :children_infos, serializer: Api::Hotels::ChildrenInfos::AttributesSerializer
  belongs_to :hotel_cancellation_policy, serializer: Api::Hotels::CancellationPolicies::AttributesSerializer

  def feature_options
    object.hotel.feature_options
  end

  def amenity_options
    object.hotel.amenity_options
  end

  def options
    Hotel::Option.where(id: object.option_ids).includes(:assets).map do |obj|
      Api::Hotels::Options::AttributesSerializer.new(obj).as_json
    end
  end

  def allow_pet
    object.hotel.allow_pet
  end
end
