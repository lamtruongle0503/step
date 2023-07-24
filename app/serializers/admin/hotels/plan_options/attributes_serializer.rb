# frozen_string_literal: true

class Admin::Hotels::PlanOptions::AttributesSerializer < ApplicationSerializer
  attributes :id, :end_date_stay, :start_date_stay, :room_ids
end
