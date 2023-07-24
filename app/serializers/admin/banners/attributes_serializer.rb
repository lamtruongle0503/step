# frozen_string_literal: true

class Admin::Banners::AttributesSerializer < ApplicationSerializer
  attributes :id, :telephone, :start_date, :end_date, :content, :option, :company_name, :email, :is_show

  has_many :prefectures, serializer: Admin::Prefectures::AttributesSerializer
  has_many :assets, serializer: Assets::AttributesSerializer
end
