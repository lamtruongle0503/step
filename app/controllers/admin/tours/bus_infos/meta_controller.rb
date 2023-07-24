# frozen_string_literal: true

class Admin::Tours::BusInfos::MetaController < ApiV1Controller
  before_action :authentication!

  def index
    tour_bus_infos = Admin::TourOperations::BusInfoOperations::MetaOperations::Index.new(actor, params).call
    render json: tour_bus_infos,
           each_serializer: Admin::Tours::BusInfos::IndexSerializer,
           root: 'data', adapter: :json
  end
end
