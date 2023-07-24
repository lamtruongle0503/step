# frozen_string_literal: true

class Admin::Tours::StartLocations::MetaController < ApiV1Controller
  before_action :authentication!

  def index
    start_locations = Admin::TourOperations::StartLocationOperations::MetaOperations::Index.new(actor,
                                                                                                params).call
    render json: start_locations,
           each_serializer: Admin::Tours::StartLocations::Meta::IndexSerializer,
           root: 'data', adapter: :json
  end
end
