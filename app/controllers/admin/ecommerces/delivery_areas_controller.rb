# frozen_string_literal: true

class Admin::Ecommerces::DeliveryAreasController < ApiV1Controller
  before_action :authentication!

  def index
    area = Admin::EcommerceOperations::DeliveryAreaOperations::Index.new(actor, params).call
    render json: area, each_serializer: Admin::Ecommerces::DeliveryAreas::IndexSerializer, root: 'ecommerces'
  end
end
