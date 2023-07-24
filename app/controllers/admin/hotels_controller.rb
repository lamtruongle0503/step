# frozen_string_literal: true

class Admin::HotelsController < ApiV1Controller
  before_action :authentication!

  def create
    hotel = Admin::HotelOperations::Create.new(actor, params).call
    render json: hotel, serializer: Admin::Hotels::CreateSerializer
  end

  def show
    hotel = Admin::HotelOperations::Show.new(actor, params).call
    render json: hotel, serializer: Admin::Hotels::ShowSerializer
  end

  def index
    hotels = Admin::HotelOperations::Index.new(actor, params).call
    render json: hotels, each_serializer: Admin::Hotels::IndexSerializer,
           meta: pagination_dict(hotels), root: 'data', adapter: :json
  end

  def destroy
    Admin::HotelOperations::Destroy.new(actor, params).call
    render json: {}
  end

  def update
    Admin::HotelOperations::Update.new(actor, params).call
    render json: {}
  end
end
