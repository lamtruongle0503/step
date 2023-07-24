# frozen_string_literal: true

class Admin::Tours::StayDepartures::BusInfos::AttributesSerializer < ApplicationSerializer
  attributes :id, :name, :concentrate_time, :depature_time, :address, :setting_date,
             :one_person_fee, :two_person_fee, :three_person_fee, :four_person_fee,
             :is_setting, :code, :tour_place_start_id
end
