# frozen_string_literal: true

class Admin::BannersController < ApiV1Controller
  before_action :authentication!

  def create
    Admin::BannerOperations::Create.new(actor, params).call
    render json: {}
  end

  def update
    Admin::BannerOperations::Update.new(actor, params).call
    render json: {}
  end

  def index
    banners = Admin::BannerOperations::Index.new(actor, params).call
    render json:            banners,
           each_serializer: Admin::Banners::IndexSerializer,
           meta: pagination_dict(banners), root: 'data', adapter: :json
  end

  def show
    banner = Admin::BannerOperations::Show.new(actor, params).call
    render json: banner, serializer: Admin::Banners::ShowSerializer, root: 'data'
  end

  def destroy
    Admin::BannerOperations::Destroy.new(actor, params).call
    render json: {}
  end
end
