# frozen_string_literal: true

class Api::V1::LifeSupports::RequestsController < ApiV1Controller
  def create
    Api::LifeSupportOperations::RequestOperations::Create.new(nil, params).call

    render json: {}, status: :ok
  end
end
