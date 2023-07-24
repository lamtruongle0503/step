# frozen_string_literal: true

class Admin::Tours::BusInfosController < ApiV1Controller
  before_action :authentication!

  def create
    Admin::TourOperations::BusInfoOperations::Create.new(actor, params).call
    render json: {}
  end

  def update
    Admin::TourOperations::BusInfoOperations::Update.new(actor, params).call
    render json: {}
  end

  def index
    bus_infos = Admin::TourOperations::BusInfoOperations::Index.new(actor, params).call
    render json: bus_infos, each_serializer: Admin::Tours::BusInfos::IndexSerializer,
           meta: pagination_dict(bus_infos), root: 'data', adapter: :json
  end

  def show
    bus_info = Admin::TourOperations::BusInfoOperations::Show.new(actor, params).call
    render json: bus_info, serializer: Admin::Tours::BusInfos::ShowSerializer
  end

  def destroy
    Admin::TourOperations::BusInfoOperations::Destroy.new(actor, params).call
    render json: {}
  end
end
