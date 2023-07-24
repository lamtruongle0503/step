# frozen_string_literal: true

require 'hotel/children_info'
class Admin::HotelOperations::ChildrenOperations::Update < ApplicationOperation
  attr_reader :hotel_children_info

  def initialize(actor, params)
    super
    @hotel = Hotel.find(params[:hotel_id])
    @hotel_children_info = @hotel.hotel_children_infos.find(params[:id])
  end

  def call
    authorize nil, Hotel::ChildrenPolicy

    ActiveRecord::Base.transaction do
      HotelContracts::ChildrenContracts::Update.new(children_info_params).valid!
      hotel_children_info.update!(children_info_params)
    end
  end

  private

  def children_info_params
    params.permit(:name, :capacity, :fee, :code, :is_accept, :unit, :created_at, :updated_at)
  end
end
