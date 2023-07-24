# frozen_string_literal: true

class Admin::Tours::StartLocations::AttributesSerializer < ApplicationSerializer
  attributes :id, :name, :address, :concentrate_time, :depature_time, :setting_date, :prefecture,
             :is_setting, :code

  def prefecture
    Admin::Prefectures::AttributesSerializer.new(object.prefecture).as_json
  end
end
