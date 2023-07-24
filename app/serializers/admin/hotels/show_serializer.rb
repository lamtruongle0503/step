# frozen_string_literal: true

class Admin::Hotels::ShowSerializer < Admin::Hotels::AttributesSerializer
  has_many :assets, serializer: Assets::AttributesSerializer
end
