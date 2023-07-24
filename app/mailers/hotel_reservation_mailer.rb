# frozen_string_literal: true

class HotelReservationMailer < ApplicationMailer
  include HotelHelper

  def notify_to_user
    @hotel_order = params[:hotel_order]
    @day_created  = format_date_jp(@hotel_order.created_at.to_date)
    @day_checkin  = format_date_jp(@hotel_order.check_in.to_date)
    @day_checkout = format_date_jp(@hotel_order.check_out.to_date)
    @type_room    = type_room_jp(@hotel_order.hotel_room.room_type)
    mail(to: '', subject: '')
  end
end
