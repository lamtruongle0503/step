# frozen_string_literal: true

class Admin::Banners::Requests::IndexSerializer < Admin::Banners::Requests::AttributesSerializer
  attribute :areas

  def areas
    object.banner.prefectures.map do |prefecture|
      if prefecture.area_setting
        Admin::AreaSettings::AttributesSerializer.new(prefecture.area_setting).as_json
      end
    end.uniq.compact_blank
  end
end
