# frozen_string_literal: true

class Admin::Coupons::AttributesSerializer < ApplicationSerializer
  attributes :id, :start_time, :end_time, :publish_date, :price, :updated_at, :image_backgrounds

  has_many :prefectures, serializer: Prefectures::AttributesSerializer
  has_many :tours, serializer: Admin::Tours::AttributesSerializer
  has_many :image_backgrounds, serializer: Assets::AttributesSerializer

  def image_backgrounds
    object.assets.select { |image| image.type == Asset::IMAGE_BACKGROUNDS }
  end
end
