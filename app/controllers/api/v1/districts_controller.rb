# frozen_string_literal: true

class Api::V1::DistrictsController < ApiV1Controller
  # before_action :authentication!

  def index
    render json: Api::DistrictOperations::Index.new(nil, params).call,
           each_serializer: Districts::IndexSerializer, root: 'districts'
  end
end
