# frozen_string_literal: true

class Admin::Tours::HostelsController < ApiV1Controller
  before_action :authentication!

  def index
    tour_hostels = Admin::TourOperations::HostelOperations::Index.new(actor, params).call
    render json: tour_hostels,
           each_serializer: Admin::Tours::Hostels::IndexSerializer,
           meta: pagination_dict(tour_hostels), root: 'data', adapter: :json
  end

  def show
    tour_hostel = Admin::TourOperations::HostelOperations::Show.new(actor, params).call
    render json:       tour_hostel,
           serializer: Admin::Tours::Hostels::ShowSerializer
  end

  def update
    Admin::TourOperations::HostelOperations::Update.new(actor, params).call
    render json: {}
  end

  def create
    Admin::TourOperations::HostelOperations::Create.new(actor, params).call
    render json: {}
  end

  def destroy
    Admin::TourOperations::HostelOperations::Destroy.new(actor, params).call
    render json: {}
  end
end
