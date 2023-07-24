# frozen_string_literal: true

class Admin::Hotels::OptionsController < ApiV1Controller
  before_action :authentication!

  def create
    Admin::HotelOperations::OptionOperations::Create.new(actor, params).call
    render json: {}
  end

  def update
    Admin::HotelOperations::OptionOperations::Update.new(actor, params).call
    render json: {}
  end

  def index
    hotel_options = Admin::HotelOperations::OptionOperations::Index.new(actor, params).call
    render json:            hotel_options,
           each_serializer: Admin::Hotels::Options::IndexSerializer
  end

  def show
    hotel_option = Admin::HotelOperations::OptionOperations::Show.new(actor, params).call
    render json:       hotel_option,
           serializer: Admin::Hotels::Options::ShowSerializer
  end

  def destroy
    Admin::HotelOperations::OptionOperations::Destroy.new(actor, params).call
    render json: {}
  end
end
