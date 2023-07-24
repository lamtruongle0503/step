# frozen_string_literal: true

class Admin::Hotels::RequestsController < ApiV1Controller
  before_action :authentication!

  def index
    requests = Admin::HotelOperations::RequestOperations::Index.new(actor, params).call
    render json: requests, each_serializer: Admin::Hotels::Requests::IndexSerializer, root: 'data',
           meta: pagination_dict(requests), adapter: :json
  end

  def create
    Admin::HotelOperations::RequestOperations::Create.new(actor, params).call
    render json: {}
  end

  def show
    request = Admin::HotelOperations::RequestOperations::Show.new(actor, params).call
    render json: request, serializer: Admin::Hotels::Requests::ShowSerializer
  end

  def update
    Admin::HotelOperations::RequestOperations::Update.new(actor, params).call
    render json: {}
  end

  def destroy
    Admin::HotelOperations::RequestOperations::Destroy.new(actor, params).call
    render json: {}
  end
end
