# frozen_string_literal: true

require 'hotel/children_info'
class Admin::HotelOperations::ChildrenOperations::Create < ApplicationOperation
  attr_reader :hotel

  def initialize(actor, params)
    super
    @hotel = Hotel.find(params[:hotel_id])
  end

  def call
    authorize nil, Hotel::ChildrenPolicy

    children_infos = []
    children_info_params[:children_infos].each do |child_params|
      HotelContracts::ChildrenContracts::Create.new(child_params.merge(hotel_id: @hotel.id)).valid!
      children_infos.push({
                            name:      child_params[:name],
                            is_accept: child_params[:is_accept],
                            fee:       child_params[:fee],
                            unit:      child_params[:unit],
                            capacity:  child_params[:capacity],
                            code:      child_params[:code],
                          })
    end
    ActiveRecord::Base.transaction do
      hotel.hotel_children_infos.import!(children_infos)
    end
  end

  private

  def children_info_params
    params.permit(children_infos: %i[name capacity fee is_accept unit created_at updated_at code])
  end
end
