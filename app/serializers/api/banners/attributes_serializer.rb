# frozen_string_literal: true

class Api::Banners::AttributesSerializer < ApplicationSerializer
  attributes :id, :start_date, :end_date, :content, :telephone, :option
  has_many :assets, serializer: Assets::AttributesSerializer
end
