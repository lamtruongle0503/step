# frozen_string_literal: true

class Api::V1::AssetsController < ApiV1Controller
  def create
    Api::AssetOperations::Create.new(nil, params).call
    render json: {}
  end
end
