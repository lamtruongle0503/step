# frozen_string_literal: true

class Admin::Ecommerces::AgenciesController < ApiV1Controller
  before_action :authentication!

  def create
    Admin::EcommerceOperations::AgencyOperations::Create.new(actor, params).call
    render json: {}
  end

  def destroy
    Admin::EcommerceOperations::AgencyOperations::Destroy.new(actor, params).call
    render json: {}
  end

  def index
    agencies = Admin::EcommerceOperations::AgencyOperations::Index.new(actor, params).call
    render json: agencies, each_serializer: Admin::Ecommerces::Agencies::IndexSerializer,
           meta: pagination_dict(agencies), root: 'data', adapter: :json
  end

  def update
    Admin::EcommerceOperations::AgencyOperations::Update.new(actor, params).call
    render json: {}
  end

  def show
    agency = Admin::EcommerceOperations::AgencyOperations::Show.new(actor, params).call
    render json: agency, serializer: Admin::Ecommerces::Agencies::IndexSerializer
  end
end
