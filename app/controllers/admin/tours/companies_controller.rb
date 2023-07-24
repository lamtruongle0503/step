# frozen_string_literal: true

class Admin::Tours::CompaniesController < ApiV1Controller
  before_action :authentication!

  def index
    tour_companies = Admin::TourOperations::CompanyOperations::Index.new(actor, params).call
    render json: tour_companies,
           each_serializer: Admin::Tours::Companies::IndexSerializer,
           meta: pagination_dict(tour_companies), root: 'data', adapter: :json
  end

  def create
    Admin::TourOperations::CompanyOperations::Create.new(actor, params).call
    render json: {}
  end

  def update
    Admin::TourOperations::CompanyOperations::Update.new(actor, params).call
    render json: {}
  end

  def destroy
    Admin::TourOperations::CompanyOperations::Destroy.new(actor, params).call
    render json: {}
  end

  def show
    tour_company = Admin::TourOperations::CompanyOperations::Show.new(actor, params).call
    render json:       tour_company,
           serializer: Admin::Tours::Companies::ShowSerializer
  end
end
