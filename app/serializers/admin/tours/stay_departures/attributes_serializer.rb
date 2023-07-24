# frozen_string_literal: true

class Admin::Tours::StayDepartures::AttributesSerializer < ApplicationSerializer
  attributes :id, :address, :concentrate_time, :depature_time, :one_person_fee,
             :two_person_fee, :three_person_fee, :four_person_fee, :setting_date,
             :name, :prefecture, :is_setting, :code

  def prefecture
    Admin::Prefectures::AttributesSerializer.new(object.prefecture).as_json
  end
end
