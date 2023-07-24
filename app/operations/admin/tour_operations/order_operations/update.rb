# frozen_string_literal: true

class Admin::TourOperations::OrderOperations::Update < ApplicationOperation
  attr_reader :tour_order, :user, :tour_cancellation_details, :total_price

  def initialize(actor, params)
    super
    @tour_order                = Tour::Order.find(params[:id])
    @total_price               = tour_order.total
    @tour_cancellation_details = tour_order.tour.tour_cancellation_policy.tour_cancellation_details
    @user                      = tour_order.user
  end

  def call
    authorize nil, Tour::Management::OrderPolicy

    ActiveRecord::Base.transaction do
      update_tour_order!
      update_tour_order_accompanies!
      update_bus_seat! if params[:status] != Tour::Order::CANCEL
    end
  end

  private

  def update_tour_order!
    total_tour_order = cal_total_tour_order(tour_order_params)
    TourContracts::OrderContracts::Update.new(tour_order_params).valid!
    tour_order.update(tour_order_params.except(:status))
    if params[:status] == Tour::Order::CANCEL
      update_bus_infos_when_cancel(tour_order)
      refund_purchased_amount(tour_order, total_price, tour_cancellation_details)
    else
      tour_order.update!(
        status: tour_order_params[:status],
        total:  total_tour_order.present? ? total_tour_order : total_price,
      )
    end
  end

  def cal_total_tour_order(tour_order_params)
    return unless tour_order_params[:used_points].present? && user.present?

    user.update!(
      point: user.point + tour_order.used_points - tour_order_params[:used_points].to_i,
    )
    total_price + tour_order.used_points - tour_order_params[:used_points].to_i
  end

  def update_tour_order_accompanies!
    tour_order_accompany_params[:tour_order_accompanies].each do |tour_order_accompany_param|
      order_accompany = tour_order.tour_order_accompanies.find(tour_order_accompany_param[:id])
      order_accompany.update!(tour_order_accompany_param)
    end
  end

  def update_bus_seat!
    seats_map = tour_order.tour_bus_info.seats_map
    tour_order.tour_order_accompanies.each do |order_accompany|
      seats_map.each do |seat_map|
        seat_map.each do |seat|
          next unless seat['name'] == order_accompany.selected_seat

          seat['status'] = Tour::BusInfo::BOOKING
          seat['full_name'] = "#{order_accompany.first_name}　#{order_accompany.last_name}"
        end
      end
    end
    tour_order.tour_bus_info.save!
  end

  def tour_order_params
    params.permit(:status, :memo, :is_cancellation_free, :refund_comfirm_date, :date_of_cancellation,
                  :used_points, :estimate_payment_amount, :estimate_payment_confirmation_date,
                  :payment_confirmation_date, :payment_method, :payment_status)
  end

  def tour_order_accompany_params
    params.permit(tour_order_accompanies: %i[
                    id address1 address2 birth_day departure_start_location depature_time email
                    first_name first_name_kana full_name furig gender is_owner is_save
                    last_name last_name_kana phone_number pickup_location post_code room
                    selected_seat telephone tour_option_id tour_special_food_id is_user
                  ])
  end
end
