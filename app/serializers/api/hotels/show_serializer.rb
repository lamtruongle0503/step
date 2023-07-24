# frozen_string_literal: true

class Api::Hotels::ShowSerializer < ApplicationSerializer
  attributes :id, :name, :pr_desc, :feature_options, :amenity_options, :check_in, :check_out, :room_total,
             :payment_options, :allow_children, :children_information, :allow_pet, :pet_information,
             :telephone, :other_information, :access_desc, :parking_desc, :address1, :address2, :postal_code
  belongs_to :prefecture, serializer: Prefectures::AttributesSerializer
  has_many :hotel_meals, serializer: Api::Hotels::Meals::AttributesSerializer
  has_many :assets, serializer: Assets::AttributesSerializer
  has_many :hotel_children_infos, serializer: Api::Hotels::ChildrenInfos::AttributesSerializer
end
