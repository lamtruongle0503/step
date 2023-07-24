# frozen_string_literal: true

class Admin::Banners::RequestsController < ApiV1Controller
  before_action :authentication!

  def index
    requests = Admin::BannerOperations::RequestOperations::Index.new(actor, params).call

    render json: requests, each_serializer: Admin::Banners::Requests::IndexSerializer,
           meta: pagination_dict(requests), root: 'data', adapter: :json
  end

  def update
    Admin::BannerOperations::RequestOperations::Update.new(actor, params).call
    render json: {}
  end

  def destroy
    Admin::BannerOperations::RequestOperations::Destroy.new(actor, params).call
    render json: {}
  end
end
