# frozen_string_literal: true

class Api::Tours::Indays::IndexSerializer < Api::Tours::AttributeSerializer
  attributes :min_price, :max_price, :category_code, :destination,
             :stopover, :is_show_guide, :tour_guide, :meal_description,
             :start_date, :end_date, :discount
  attr_reader :adult_dayoff_amount_fee, :adult_weekday_amount_fee

  def initialize(object, options = {})
    super
    @adult_dayoff_amount_fee = object.tour_information.adult_dayoff_amount
    @adult_weekday_amount_fee = object.tour_information.adult_weekday_amount
  end

  has_one :tour_information, serializer: Api::Tours::Indays::Informations::AttributesSerializer
  has_many :tour_start_locations, serializer: Api::Tours::Indays::StartLocations::AttributeSerializer

  def min_price
    [adult_dayoff_amount_fee, adult_weekday_amount_fee].min.to_f.round
  end

  def max_price
    [adult_dayoff_amount_fee, adult_weekday_amount_fee].max.to_f.round
  end

  def category_code
    object.tour_category.code
  end
end
