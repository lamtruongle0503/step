# frozen_string_literal: true

class Api::V1::Banners::RequestsController < ApiV1Controller
  def create
    Api::BannerOperations::RequestOperations::Create.new(nil, params).call

    render json: {}, status: :ok
  end
end
