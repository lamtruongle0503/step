# frozen_string_literal: true

class Api::V1::News::SyncController < ApiV1Controller
  def create
    Api::NewOperations::SyncOperations::Create.new(nil, params).call
    render json: {}
  end
end
