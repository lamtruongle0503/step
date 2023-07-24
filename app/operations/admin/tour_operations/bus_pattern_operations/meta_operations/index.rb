# frozen_string_literal: true

require 'tour/bus_pattern'
class Admin::TourOperations::BusPatternOperations::MetaOperations::Index < ApplicationOperation
  def call
    @q = Tour::BusPattern.find_bus_pattern_by_map.ransack(params[:q])
    @q.result(distinct: true)
  end
end
