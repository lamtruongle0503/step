# frozen_string_literal: true

class Api::V1::Tours::StaysController < ApiV1Controller
  before_action :authentication_ec!

  def index
    tours_stay = Api::TourOperations::StayOperations::Index.new(@actor_ec, params).call
    render json: tours_stay, each_serializer: Api::Tours::Stays::IndexSerializer,
           meta: pagination_dict(tours_stay), root: 'data', adapter: :json
  end

  def show
    tour_stay = Api::TourOperations::StayOperations::Show.new(@actor_ec, params).call
    render json:                tour_stay,
           serializer:          Api::Tours::Stays::ShowSerializer,
           address:             params.to_unsafe_h['address'],
           tour_place_start_id: params.to_unsafe_h['tour_place_start_id'],
           root:                'tours'
  end
end
