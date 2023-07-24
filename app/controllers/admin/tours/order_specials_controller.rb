# frozen_string_literal: true

class Admin::Tours::OrderSpecialsController < ApiV1Controller
  def show
    order_special = Admin::TourOperations::OrderSpecialOperations::Show.new(actor, params).call
    render json: order_special, serializer: Admin::Tours::OrderSpecials::ShowSerializer
  end

  def index
    order_specials = Admin::TourOperations::OrderSpecialOperations::Index.new(actor, params).call
    render json: order_specials, each_serializer: Admin::Tours::OrderSpecials::IndexSerializer,
           root: 'data', adapter: :json
  end
end
