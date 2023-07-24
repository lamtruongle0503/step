# frozen_string_literal: true

class Api::Hotels::AttributesSerializer < ApplicationSerializer
  attributes :id, :name, :pr_desc, :min_price, :max_price, :category_code, :plans
  attr_reader :room_settings, :check_in_date

  has_many :assets, serializer: Assets::AttributesSerializer

  def initialize(object, options = {})
    super
    @params = options[:params]
    @check_in_date = @params[:hotel_plans_hotel_room_settings_date_gteq]&.to_date || Time.now.to_date
    @room_settings = object.hotel_room_settings
                           .where('date >= ? AND status = ?', check_in_date,
                                  Hotel::RoomSetting.statuses[Hotel::RoomSetting::OPEN])
  end

  def plans
    object.hotel_plans.setting_show.map do |plan|
      Api::Hotels::Plans::Meta::AttributesSerializer.new(plan, check_in_date: check_in_date).as_json
    end
  end

  def category_code
    Hotel.name
  end

  def min_price
    room_settings.pluck(:two_people_fee).compact.min
  end

  def max_price
    room_settings.pluck(:ten_person_fee).compact.max
  end
end
