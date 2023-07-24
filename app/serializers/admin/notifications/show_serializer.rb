# frozen_string_literal: true

class Admin::Notifications::ShowSerializer < Admin::Notifications::AttributesSerializer
  attributes :gender, :is_gender, :is_prefecture, :is_resend, :month_birthday

  has_many :prefectures, serializer: Prefectures::AttributesSerializer
  has_one :asset, serializer: Assets::AttributesSerializer

  def description
    object.description
  end
end
