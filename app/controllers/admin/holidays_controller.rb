# frozen_string_literal: true

class Admin::HolidaysController < ApiV1Controller
  before_action :authentication!

  def create
    Admin::HolidayOperations::Create.new(actor, params).call
    render json: {}
  end

  def update
    Admin::HolidayOperations::Update.new(actor, params).call
    render json: {}
  end

  def index
    holidays = Admin::HolidayOperations::Index.new(actor, params).call
    render json:            holidays,
           each_serializer: Admin::Holidays::IndexSerializer,
           meta: pagination_dict(holidays), root: 'data', adapter: :json
  end

  def show
    holiday = Admin::HolidayOperations::Show.new(actor, params).call
    render json: holiday, serializer: Admin::Holidays::ShowSerializer, root: 'data'
  end

  def destroy
    Admin::HolidayOperations::Destroy.new(actor, params).call
    render json: {}
  end
end
