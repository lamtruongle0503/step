# frozen_string_literal: true

require 'tour/order'
require 'tour/order_log'
class Admin::TourOperations::OrderOperations::Create < ApplicationOperation # rubocop:disable Metrics/ClassLength
  attr_reader :tour, :user

  def initialize(actor, params)
    super
    @tour = Tour.find(params[:tour_id])
    @user = User.find(params[:user_id]) if params[:user_id]
  end

  def call
    authorize nil, Tour::Management::OrderPolicy
    ActiveRecord::Base.transaction do
      tour_order = create_tour_order!
      tour_bus_info = update_seat_tour_bus_info(tour_order)
      create_order_accompany(tour_order, tour_bus_info)
      total_tour_bus_seat_map = total_tour_bus_seat_map_admin(tour_order, tour_bus_info)
      update_coupon_user!(tour_order) if tour_order.coupon_id.present?
      if tour.type_locate == Tour::INDAY
        total_tour_information = total_tour_information(tour_order, params)
        total_price_special_food = total_price_food_admin(tour_order)
        total_tour_order_inday = total_tour_order_inday(
          tour_order, total_tour_information, total_tour_bus_seat_map, total_price_special_food
        )
        update_tour_order_inday(tour_order, total_tour_order_inday)
        create_tour_order_log_inday(tour_order.reload)
      else
        total_price_stay_departure = total_tour_stay_departure_price(tour_order, tour_order_params)
        total_price_option = total_price_food_admin(tour_order)
        total_tour_order_stay = total_tour_order_stay(
          tour_order, total_tour_bus_seat_map,
          total_price_option, total_price_stay_departure
        )
        update_tour_order_stay(tour_order, total_tour_order_stay)
        create_tour_order_log_stay(tour_order.reload)
      end
      update_tour_user_point(user, tour_order) if user
      update_available_seats(tour_order, tour_bus_info)
      send_email_to_user(tour, tour_order)
    end
  end

  private

  def create_tour_order!
    TourContracts::OrderContracts::Create.new(
      tour_order_params.merge(
        tour_id: tour.id,
        user_id: user.present? ? user.id : nil,
        point:   user.present? ? user.point.to_i + user.point_bonus.to_i : 0,
      ),
    ).valid!
    Tour::Order.create!(
      tour_order_params.merge!(tour_id: tour.id, user_id: user.present? ? user.id : nil),
    )
  end

  def update_seat_tour_bus_info(tour_order)
    tour_bus_info = tour.tour_bus_infos.find(tour_order.tour_bus_info_id)
    tour_bus_info.with_lock do
      if tour_bus_info.seats_map.blank?
        tour_bus_info.update!(
          seats_map: tour_bus_info.tour_bus_pattern.map,
        )
      end
    end
    tour_bus_info
  end

  def create_order_accompany(tour_order, tour_bus_info)
    seat_selection = []
    params[:tour_order_accompanies].each do |order_accompany|
      seat_selection << order_accompany[:selected_seat]
      if order_accompany[:is_owner] == false && order_accompany[:is_save] == true && user.present?
        create_user_contact(order_accompany)
      end
      TourContracts::OrderAccompanyContracts::Create.new(
        order_accompany.permit!.merge(tour_bus_info: tour_bus_info, user: @user),
      ).valid!
      name_option = tour.tour_special_foods.find_by(id: order_accompany[:tour_special_food_id]) ||
                    tour.tour_options.find_by(id: order_accompany[:tour_option_id])
      tour_order.tour_order_accompanies.create!(order_accompany.merge!(name_option: name_option))
    end
    update_tour_bus_info(seat_selection, tour_bus_info.seats_map)
    tour_bus_info.save!
  end

  def create_user_contact(order_accompany)
    UserContactContracts::AdminContracts::Create.new(order_accompany.permit!).valid!
    user.user_contacts.create!(
      first_name:      order_accompany[:first_name],
      last_name:       order_accompany[:last_name],
      first_name_kana: order_accompany[:first_name_kana],
      last_name_kana:  order_accompany[:last_name_kana],
      gender:          order_accompany[:gender],
      birth_day:       order_accompany[:birth_day],
      post_code:       order_accompany[:post_code],
      address1:        order_accompany[:address1],
      address2:        order_accompany[:address2],
      email:           order_accompany[:email],
      phone_number:    order_accompany[:phone_number],
      telephone:       order_accompany[:telephone],
      full_name:       order_accompany[:full_name],
      furigana:        order_accompany[:furigana],
    )
  end

  def update_coupon_user!(tour_order)
    user.coupon_users.create!(
      coupon_id: tour_order.coupon_id,
      user_id:   user.present? ? user.id : nil,
    )
  end

  def update_tour_order_inday(tour_order, total_tour_order_inday)
    cal_point = cal_point_tour_order(tour_order, tour, total_tour_order_inday,
                                     total_tour_order_inday[:total_tour_order_inday])
    received_bonus_point = cal_point.present? ? cal_point[:point_bonus] : 0
    received_point = cal_point.present? ? cal_point[:point_normal] : 0
    date_of_cancellation_fee = cal_date_of_cancellation(
      tour_order.tour_bus_info.departure_date, tour.tour_cancellation_policy.tour_cancellation_details
    )
    tour_order.update!(
      total_tour:               total_tour_order_inday[:total_tour_information],
      total_tour_bus_seat_map:  total_tour_order_inday[:total_tour_bus_seat_map],
      total_price_special_food: total_tour_order_inday[:total_price_special_food],
      coupon_discount:          total_tour_order_inday[:tour_coupon],
      initial_price:            total_tour_order_inday[:initial_price],
      total:                    total_tour_order_inday[:total_tour_order_inday],
      received_bonus_point:     received_bonus_point,
      received_point:           received_point,
      date_of_cancellation_fee: date_of_cancellation_fee,
    )
  end

  def create_tour_order_log_inday(tour_order)
    price_special_food = count_amount_special_food(
      tour_order.tour_order_accompanies,
    ).merge!(price_special_food_admin(tour_order))
    price_tour_information = count_amount_tour_order(
      tour_order.tour_order_accompanies, params
    ).merge!(price_tour_information(tour_order))
    amount_tour_bus_seat_map = amount_tour_bus_seat_map(
      tour_order, tour_order.tour_bus_info
    ).merge!(tour_order.price_seat)
    tour_order.create_tour_order_log!(
      tour:                       tour,
      tour_hostels:               [],
      tour_information:           tour.tour_information,
      tour_stay_departures:       {},
      tour_cancellation_patterns: {},
      tour_options:               [],
      price_special_food:         price_special_food,
      price_tour_information:     price_tour_information,
      amount_tour_bus_seat_map:   amount_tour_bus_seat_map,
    )
  end

  def create_tour_order_log_stay(tour_order)
    amount_tour_bus_seat_map = amount_tour_bus_seat_map(
      tour_order, tour_order.tour_bus_info
    ).merge!(tour_order.price_seat)
    tour_order.create_tour_order_log!(
      tour:                       tour,
      tour_hostels:               tour.hostels.to_json,
      tour_information:           tour.tour_information,
      tour_stay_departures:       tour_order.tour_bus_info.tour_stay_departure,
      tour_cancellation_patterns: {},
      tour_options:               price_option_admin(tour_order),
      price_special_food:         {},
      price_tour_information:     count_amount_tour_order(tour_order.tour_order_accompanies, params),
      amount_tour_bus_seat_map:   amount_tour_bus_seat_map,
    )
  end

  def update_tour_order_stay(tour_order, total_tour_order_stay)
    cal_point = cal_point_tour_order(tour_order, tour, total_tour_order_stay,
                                     total_tour_order_stay[:total_tour_order_stay])
    received_bonus_point = cal_point.present? ? cal_point[:point_bonus] : 0
    received_point = cal_point.present? ? cal_point[:point_normal] : 0
    date_of_cancellation_fee = cal_date_of_cancellation(
      tour_order.tour_bus_info.departure_date, tour.tour_cancellation_policy.tour_cancellation_details
    )
    tour_order.update!(
      total_tour_bus_seat_map:    total_tour_order_stay[:total_tour_bus_seat_map],
      total_tour_option:          total_tour_order_stay[:total_price_option],
      total_price_stay_departure: total_tour_order_stay[:total_price_stay_departure],
      coupon_discount:            total_tour_order_stay[:tour_coupon],
      initial_price:              total_tour_order_stay[:initial_price],
      total:                      total_tour_order_stay[:total_tour_order_stay],
      received_bonus_point:       received_bonus_point,
      received_point:             received_point,
      date_of_cancellation_fee:   date_of_cancellation_fee,
    )
  end

  def tour_order_params
    params.permit(
      :cancellation_fee, :cancellation_free, :coupon_id, :coupon_discount, :date_of_cancellation,
      :departure_start_location, :discount_amount, :invoice_desc, :is_seats_bus_free, :memo, :number_people,
      :order_no, :payment_method, :payment_note, :payment_status, :seat_selection, :status, :used_points,
      :tour_bus_info_id, :tour_stay_departure_id, :depature_time, :estimate_payment_amount, :departure_date,
      :estimate_payment_confirmation_date, :payment_confirmation_date, price_seat: {}, room: {}
    )
  end

  def tour_order_accompany_params
    params.permit(tour_order_accompanies: %i[
                    address1 address2 birth_day departure_start_location depature_time email
                    first_name first_name_kana full_name furig gender is_owner is_save last_name
                    last_name_kana phone_number pickup_location post_code room selected_seat
                    telephone tour_option_id tour_special_food_id is_user name_option price_food
                  ])
  end

  def tour_order_log_params
    params.permit(tour_order_log: %i[
                    tour_information tour_stay_departures tour_cancellation_patterns
                  ])
  end
end
