# frozen_string_literal: true

class Api::Hotels::RoomSettings::AttributesSerializer < ApplicationSerializer
  attributes :id, :date, :remain_room, :reservation_number, :one_person_fee,
             :two_people_fee, :three_people_fee, :four_people_fee, :five_people_fee,
             :six_person_fee, :seven_person_fee, :eight_person_fee, :nine_person_fee,
             :ten_person_fee, :type_plan, :status

  def type_plan
    object.hotel_plan.type_plan
  end
end
