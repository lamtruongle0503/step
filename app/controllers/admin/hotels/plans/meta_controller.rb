# frozen_string_literal: true

class Admin::Hotels::Plans::MetaController < ApiV1Controller
  before_action :authentication!

  def index
    hotel_plans = Admin::HotelOperations::PlanOperations::MetaOperations::Index.new(actor, params).call
    render json: hotel_plans,
           each_serializer: Admin::Hotels::Plans::Meta::IndexSerializer,
           root: 'data', adapter: :json
  end
end
