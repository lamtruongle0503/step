# frozen_string_literal: true

class Api::Hotels::Plans::Meta::AttributesSerializer < ApplicationSerializer
  attributes :id, :name, :type_meal, :rooms, :check_out, :is_sale_off, :hotel_meal, :type_plan

  def initialize(object, options = {})
    super
    @check_in_date = options[:check_in_date]
  end

  def rooms
    object.hotel_rooms.distinct.map do |room|
      Api::Hotels::Rooms::Meta::AttributesSerializer.new(room,
                                                         { plan:          object,
                                                           check_in_date: @check_in_date }).as_json
    end
  end

  def hotel_meal
    Api::Hotels::Meals::AttributesSerializer.new(object.hotel_meal).as_json
  end

  def type_meal
    object.type_meal.map do |item|
      Hotel::Plan.meals.keys[item.to_i]
    end
  end
end
