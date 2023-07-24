# frozen_string_literal: true

class Api::HotelOperations::RequestOperations::Create < ApplicationOperation
  def initialize(actor, params)
    super
    @hotel = Hotel.find(params[:hotel_id])
    @plan = @hotel.hotel_plans.find(params[:plan_id])
    @room = @plan.hotel_rooms.find(params[:room_id])
  end

  def call
    HotelContracts::RequestContracts::Create.new(request_params).valid!
    request_no = generate_code(Hotel::Request.name)

    ActiveRecord::Base.transaction do
      @hotel_request = @hotel.hotel_requests.create!(request_params.merge(request_no:    request_no,
                                                                          hotel_plan_id: @plan.id,
                                                                          hotel_room_id: @room.id))
      send_mail_hotel_request(@hotel_request)
    end

    { id: @hotel_request.id }
  end

  private

  def request_params
    params.permit(:full_name, :phone_number, :email, :check_in, :check_out, :total_person, :total_room,
                  :room_type, :comments)
  end
end
