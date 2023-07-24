# frozen_string_literal: true

class Api::V1::LifeSupportsController < ApiV1Controller
  def index
    life_supports = Api::LifeSupportOperations::Index.new(nil, params).call
    render json: life_supports,
           each_serializer: Api::LifeSupports::IndexSerializer,
           meta: pagination_dict(life_supports), root: 'data', adapter: :json
  end

  def show
    life_support = Api::LifeSupportOperations::Show.new(nil, params).call
    render json:       life_support,
           serializer: Api::LifeSupports::ShowSerializer
  end
end
