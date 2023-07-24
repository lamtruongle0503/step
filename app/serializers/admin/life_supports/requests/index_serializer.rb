# frozen_string_literal: true

class Admin::LifeSupports::Requests::IndexSerializer < Admin::LifeSupports::Requests::AttributesSerializer
  attribute :areas

  def areas
    object.life_support.prefectures.map do |prefecture|
      if prefecture.area_setting
        Admin::AreaSettings::AttributesSerializer.new(prefecture.area_setting).as_json
      end
    end.uniq.compact_blank
  end
end
