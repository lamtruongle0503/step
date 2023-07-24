# frozen_string_literal: true

class Admin::Hotels::PlanOptions::ShowSerializer < Admin::Hotels::PlanOptions::AttributesSerializer
  belongs_to :hotel_plan, serializer: Admin::Hotels::Plans::AttributesSerializer
end
