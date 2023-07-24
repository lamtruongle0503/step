# frozen_string_literal: true

class Api::V1::BannersController < ApiV1Controller
  def index
    banners = Api::BannerOperations::Index.new(nil, params).call
    render json: banners,
           each_serializer: Api::Banners::IndexSerializer,
           meta: pagination_dict(banners), root: 'data', adapter: :json
  end

  def show
    banner = Api::BannerOperations::Show.new(nil, params).call
    render json:       banner,
           serializer: Api::Banners::ShowSerializer
  end
end
