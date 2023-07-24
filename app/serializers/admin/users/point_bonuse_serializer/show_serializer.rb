# frozen_string_literal: true

module Admin::Users::PointBonuseSerializer
  class ShowSerializer < AttributesSerializer
    attributes :title, :description
  end
end
