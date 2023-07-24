# frozen_string_literal: true

class Admin::HotelOperations::RequestOperations::Update < ApplicationOperation
  def initialize(actor, params)
    super
    @request = Hotel::Request.find(params[:id])
  end

  def call
    authorize nil, Hotel::RequestPolicy

    HotelContracts::RequestContracts::Update.new(request_params).valid!
    ActiveRecord::Base.transaction do
      @request.update!(request_params)
    end
  end

  private

  def request_params
    params.permit(:full_name, :phone_number, :email, :check_in, :check_out, :total_person, :total_room,
                  :room_type, :comments, :status)
  end
end
