# frozen_string_literal: true

class Admin::Tours::ManagementsController < ApiV1Controller
  before_action :authentication!

  def index
    managements = Admin::TourOperations::ManagementOperations::Index.new(actor, params).call
    render json: managements, each_serializer: Admin::Tours::Managements::IndexSerializer,
           meta: pagination_dict(managements), root: 'data', adapter: :json
  end

  def destroy
    Admin::TourOperations::ManagementOperations::Destroy.new(actor, params).call
    render json: {}
  end

  def show
    management = Admin::TourOperations::ManagementOperations::Show.new(actor, params).call
    render json: management, serializer: Admin::Tours::Managements::ShowSerializer, root: 'data'
  end
end
