# frozen_string_literal: true

require 'hotel/option'
class Admin::HotelOperations::OptionOperations::Create < ApplicationOperation
  def call
    authorize nil, Hotel::OptionPolicy

    ActiveRecord::Base.transaction do
      hotel = Hotel.find(params[:hotel_id])
      hotel_option = create_hotel_option(hotel)
      upload_image_hotel(hotel_option) if params[:file]
    end
  end

  private

  def create_hotel_option(hotel)
    HotelContracts::OptionContracts::Create.new(hotel_option_params).valid!
    hotel.hotel_options.create!(hotel_option_params)
  end

  def hotel_option_params
    params.permit(:description, :is_use, :management_name, :name, :price, :unit, :created_at, :updated_at)
  end

  def upload_image_hotel(hotel_option)
    return unless params[:file].is_a? Array

    params[:file].each do |file|
      upload_multiple_file(hotel_option, file[:url], file[:type], file[:file_type])
    end
  end
end
