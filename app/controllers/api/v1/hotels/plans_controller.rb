# frozen_string_literal: true

class Api::V1::Hotels::PlansController < ApiV1Controller
  def index
    hotel_plans = Api::HotelOperations::PlanOperations::Index.new(nil, params).call
    render json: hotel_plans, each_serializer: Api::Hotels::Plans::IndexSerializer, params: params,
           meta: count_record(hotel_plans), root: 'hotel_plans', adapter: :json
  end
end
