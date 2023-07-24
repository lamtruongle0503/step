# frozen_string_literal: true

class Admin::Hotels::CategoriesController < ApiV1Controller
  before_action :authentication!

  def index
    categories = Admin::HotelOperations::CategoryOperations::Index.new(actor, params).call
    render json: categories, each_serializer: Admin::Hotels::Categories::IndexSerializer
  end

  def create
    Admin::HotelOperations::CategoryOperations::Create.new(actor, params).call
    render json: {}
  end
end
