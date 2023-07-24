# frozen_string_literal: true

class Api::Tours::Indays::Prefectures::IndexSerializer < ApplicationSerializer
  attributes :prefectures

  def prefectures
    arr = []
    object.map(&:tour_start_locations).flatten.each do |start_location|
      prefecture_name = start_location.prefecture
      arr.push(Prefectures::AttributesSerializer.new(prefecture_name).as_json)
    end
    arr.uniq
  end
end
