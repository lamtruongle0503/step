# frozen_string_literal: true

class Admin::LifeSupports::RequestsController < ApiV1Controller
  before_action :authentication!

  def index
    requests = Admin::LifeSupportOperations::RequestOperations::Index.new(actor, params).call

    render json: requests, each_serializer: Admin::LifeSupports::Requests::IndexSerializer,
           meta: pagination_dict(requests), root: 'data', adapter: :json
  end

  def update
    Admin::LifeSupportOperations::RequestOperations::Update.new(actor, params).call
    render json: {}
  end

  def destroy
    Admin::LifeSupportOperations::RequestOperations::Destroy.new(actor, params).call
    render json: {}
  end
end
