# frozen_string_literal: true

class Api::V1::Fortunes::SyncController < ApiV1Controller
  def create
    Api::FortuneOperations::SyncOperations::Create.new(nil, params).call
    render json: {}
  end
end
