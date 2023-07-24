# frozen_string_literal: true

class Api::V1::Tours::SearchController < ApiV1Controller
  before_action :authentication!

  def index
    tours = Api::TourOperations::SearchOperations::Index.new(actor, params).call
    render json: tours, each_serializer: Api::Tours::Search::IndexSerializer,
           meta: pagination_dict(tours), root: 'data', adapter: :json
  end
end
