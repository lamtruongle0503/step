# frozen_string_literal: true

class Admin::Tours::PlaceStartsController < ApiV1Controller
  before_action :authentication!

  def index
    tour_start_locations = Admin::TourOperations::PlaceStartOperations::Index.new(actor, params).call
    render json: tour_start_locations, each_serializer: Admin::Tours::PlaceStarts::IndexSerializer,
           root: 'data', adapter: :json
  end

  def create
    Admin::TourOperations::PlaceStartOperations::Create.new(actor, params).call
    render json: {}
  end

  def update
    Admin::TourOperations::PlaceStartOperations::Update.new(actor, params).call
    render json: {}
  end

  def show
    tour_place_start = Admin::TourOperations::PlaceStartOperations::Show.new(actor, params).call
    render json: tour_place_start, serializer: Admin::Tours::PlaceStarts::ShowSerializer, root: 'data'
  end
end
