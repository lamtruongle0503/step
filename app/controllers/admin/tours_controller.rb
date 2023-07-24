# frozen_string_literal: true

class Admin::ToursController < ApiV1Controller
  before_action :authentication!

  def index
    tours = Admin::TourOperations::Index.new(actor, params).call
    render json: tours,
           each_serializer: Admin::Tours::IndexSerializer,
           meta: pagination_dict(tours), root: 'data', adapter: :json
  end

  def create
    tour = Admin::TourOperations::Create.new(actor, params).call
    render json: tour.id
  end

  def destroy
    Admin::TourOperations::Destroy.new(actor, params).call
    render json: {}
  end

  def update
    Admin::TourOperations::Update.new(actor, params).call
    render json: {}
  end

  def show
    tour = Admin::TourOperations::Show.new(actor, params).call
    render json: tour, serializer: Admin::Tours::ShowSerializer
  end
end
