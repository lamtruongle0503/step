# frozen_string_literal: true

class CancelHotelReservationMailer < ApplicationMailer
  include HotelHelper

  def notify_to_hotel
    @hotel_order  = params[:hotel_order]
    @day_cancel   = format_date_jp(@hotel_order.date_cancel.to_date)
    @day_created  = format_date_jp(@hotel_order.created_at.to_date)
    @day_checkin  = format_date_jp(@hotel_order.check_in.to_date)
    @day_checkout = format_date_jp(@hotel_order.check_out.to_date)
    @type_room    = type_room_jp(@hotel_order.hotel_room.room_type)
    mail(to: '', subject: '')
  end

  def notify_to_user
    @hotel_order  = params[:hotel_order]
    @day_cancel   = format_date_jp(@hotel_order.date_cancel.to_date)
    @day_created  = format_date_jp(@hotel_order.created_at.to_date)
    @day_checkin  = format_date_jp(@hotel_order.check_in.to_date)
    @day_checkout = format_date_jp(@hotel_order.check_out.to_date)
    @type_room    = type_room_jp(@hotel_order.hotel_room.room_type)
    mail(to: '', subject: '')
  end
end
