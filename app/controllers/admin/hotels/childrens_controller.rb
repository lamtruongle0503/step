# frozen_string_literal: true

class Admin::Hotels::ChildrensController < ApiV1Controller
  before_action :authentication!

  def index
    hotel_childrens = Admin::HotelOperations::ChildrenOperations::Index.new(actor, params).call
    render json: hotel_childrens, each_serializer: Admin::Hotels::Childrens::IndexSerializer
  end

  def show
    hotel_childrens = Admin::HotelOperations::ChildrenOperations::Show.new(actor, params).call
    render json:       hotel_childrens,
           serializer: Admin::Hotels::Childrens::ShowSerializer
  end

  def create
    Admin::HotelOperations::ChildrenOperations::Create.new(actor, params).call
    render json: {}
  end

  def destroy
    Admin::HotelOperations::ChildrenOperations::Destroy.new(actor, params).call
    render json: {}
  end

  def update
    Admin::HotelOperations::ChildrenOperations::Update.new(actor, params).call
    render json: {}
  end
end
