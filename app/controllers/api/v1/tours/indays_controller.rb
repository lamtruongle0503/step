# frozen_string_literal: true

class Api::V1::Tours::IndaysController < ApiV1Controller
  before_action :authentication_ec!

  def index
    tours_inday = Api::TourOperations::IndayOperations::Index.new(@actor_ec, params).call
    render json: tours_inday, each_serializer: Api::Tours::Indays::IndexSerializer,
           meta: pagination_dict(tours_inday), root: 'data', adapter: :json
  end

  def show
    tour_inday = Api::TourOperations::IndayOperations::Show.new(@actor_ec, params).call
    render json:                tour_inday,
           serializer:          Api::Tours::Indays::ShowSerializer,
           address:             params.to_unsafe_h['address'],
           tour_place_start_id: params.to_unsafe_h['tour_place_start_id'],
           root:                'tours'
  end
end
