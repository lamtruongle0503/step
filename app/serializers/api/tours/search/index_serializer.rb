# frozen_string_literal: true

class Api::Tours::Search::IndexSerializer < ApplicationSerializer
  attributes :id, :name, :code, :title, :max_price, :min_price, :category_code,
             :start_date, :end_date, :destination, :discount

  has_many :assets, serializer: Assets::AttributesSerializer
  has_one :tour_information, serializer: Api::Tours::Indays::Informations::AttributesSerializer

  attr_reader :room_settings

  def initialize(object, options = {})
    super
    @room_settings = object.hotel_room_settings.where(date: Time.now.to_date) if object.instance_of?(Hotel)
  end

  def code
    object.code if object.instance_of?(Tour)
  end

  def title
    object.instance_of?(Tour) ? object.title : object.pr_desc
  end

  def max_price
    max_price = if object.instance_of?(Tour)
                  if object.type_locate == Tour::INDAY
                    [object.tour_information.adult_dayoff_amount,
                     object.tour_information.adult_weekday_amount].max
                  else
                    object.tour_information.max_price
                  end
                else
                  room_settings.pluck(:ten_person_fee).max
                end
    max_price.to_f.round
  end

  def min_price
    min_price = if object.instance_of?(Tour)
                  if object.type_locate == Tour::INDAY
                    [object.tour_information.adult_dayoff_amount,
                     object.tour_information.adult_weekday_amount].min
                  else
                    object.tour_information.min_price
                  end
                else
                  room_settings.pluck(:two_people_fee).min
                end
    min_price.to_f.round
  end

  def category_code
    if object.instance_of?(Tour)
      object.tour_category.code
    else
      object.class.name.downcase
    end
  end

  def start_date
    object.start_date if object.instance_of?(Tour)
  end

  def end_date
    object.end_date if object.instance_of?(Tour)
  end

  def destination
    object.destination if object.instance_of?(Tour)
  end
end
