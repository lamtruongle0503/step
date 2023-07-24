# frozen_string_literal: true

class TourOrderMailer < ApplicationMailer
  include TourOrderHelper
  def mail_to_user
    @tour_order           = params[:tour_order]
    @tour_order_accompany = params[:tour_order_accompany]
    @day_created          = tour_order_format_date_jp(@tour_order.created_at.to_date)
    @departure_date       = tour_order_format_date_jp(@tour_order.departure_date.to_date)
    @amount_tour_order    = @tour_order.tour_order_log.price_tour_information
    @tour_cancellations   = @tour_order.tour.tour_cancellation_policy.tour_cancellation_details
    if @tour_order.tour.type_locate == Tour::STAY
      @day_end = tour_order_format_date_jp(
        (@tour_order.departure_date + @tour_order.tour.stayed_nights.day).to_date,
      )
      @address            = @tour_order.tour_bus_info&.tour_stay_departure&.address
    else
      @address            = @tour_order.tour_bus_info&.tour_start_location&.address
      @price_special_food = @tour_order.tour_order_log.price_special_food
    end

    mail(to: '', subject: '')
  end
end
