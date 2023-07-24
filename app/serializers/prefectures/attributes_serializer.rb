# frozen_string_literal: true

class Prefectures::AttributesSerializer < ApplicationSerializer
  attributes :id, :name, :prefecture_jis_code, :location_area_id, :area_setting_id
end
