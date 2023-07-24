# frozen_string_literal: true

class Admin::LifeSupports::AttributesSerializer < ApplicationSerializer
  attributes :id, :telephone, :start_date, :end_date, :content, :option, :company_name, :email, :assets

  has_many :prefectures, serializer: Admin::Prefectures::AttributesSerializer

  def assets
    object.assets.map { |asset| Assets::AttributesSerializer.new(asset).as_json }.compact
  end
end
