# frozen_string_literal: true

class Admin::Tours::BusPatterns::MetaController < ApiV1Controller
  before_action :authentication!

  def index
    tour_bus_patterns = Admin::TourOperations::BusPatternOperations::MetaOperations::Index.new(actor,
                                                                                               params).call
    render json: tour_bus_patterns,
           each_serializer: Admin::Tours::BusPatterns::Meta::IndexSerializer,
           root: 'data', adapter: :json
  end
end
