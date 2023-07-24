# frozen_string_literal: true

class Admin::Hotels::Plans::RoomSettings::IndexSerializer < ApplicationSerializer
  attributes :id, :date, :one_person_fee, :two_people_fee, :three_people_fee, :four_people_fee,
             :five_people_fee, :six_person_fee, :seven_person_fee, :eight_person_fee, :nine_person_fee,
             :ten_person_fee, :remain_room, :reservation_number, :status
end
