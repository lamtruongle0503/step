# frozen_string_literal: true

class Api::Tours::StayDepartures::Info::AttributeSerializer < ApplicationSerializer
  attributes :id, :concentrate_time, :depature_time, :four_person_fee, :one_person_fee, :setting_date,
             :three_person_fee, :two_person_fee, :name, :address, :prefecture, :is_setting, :code

  def prefecture
    object.prefecture.name
  end

  def four_person_fee
    (object.four_person_fee - object.tour.discount).to_f.round
  end

  def three_person_fee
    (object.three_person_fee - object.tour.discount).to_f.round
  end

  def two_person_fee
    (object.two_person_fee - object.tour.discount).to_f.round
  end

  def one_person_fee
    (object.one_person_fee - object.tour.discount).to_f.round
  end
end
