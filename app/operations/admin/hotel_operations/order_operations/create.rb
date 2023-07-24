# frozen_string_literal: true

class Admin::HotelOperations::OrderOperations::Create < ApplicationOperation
  attr_reader :hotel, :plan, :room, :user, :room_settings, :number_night, :date_check_in, :date_check_out

  def initialize(actor, params)
    super
    required_params
    @date_check_in = params[:check_in].to_date
    @date_check_out = params[:check_out].to_date
    @number_night = (date_check_out - date_check_in).to_i
    @hotel = Hotel.find(params[:hotel_id])
    @plan = @hotel.hotel_plans.find(params[:plan_id])
    @room = @plan.hotel_rooms.find(params[:room_id])
    @user = User.find(params[:user_id]) if params[:user_id]
    @room_settings = plan.hotel_room_settings.date_order(room.id, date_check_in, date_check_out)
  end

  def call # rubocop:disable Metrics/AbcSize
    authorize nil, Hotel::OrderPolicy

    ActiveRecord::Base.transaction do
      amount_room = calc_price_room(room_settings, params[:check_in], params[:number_night],
                                    params[:adult_total], params[:total_room])
      amount_option = calc_price_options(params[:option_ids], amount_room, params[:total_room])
      amount_children = calc_price_childrens(plan, amount_room, params[:childrens], params[:adult_total],
                                             params[:total_room], params[:number_night])
      amount_sale_off_stay_night = calc_price_sale_off_stay_nights(plan, params[:number_night], amount_room)
      amount_total_price = total_amount_price(amount_room, amount_option, amount_children,
                                              amount_sale_off_stay_night)
      @hotel_order_accompany = create_order_accompany!
      @hotel_order = create_hotel_order(
        @hotel_order_accompany.reload,
        amount_room,
        amount_option,
        amount_children,
        amount_sale_off_stay_night,
        amount_total_price,
      )
      create_order_log!(@hotel_order.reload)
      use_point(@hotel_order)
      create_point_bonus(@hotel_order)
      remaining_rooms
      send_mail_booking(@hotel_order)
    end
  end

  private

  def required_params
    return raise BadRequestError, check_in: I18n.t('models.can_not_blank') unless params[:check_in]
    return raise BadRequestError, number_night: I18n.t('models.can_not_blank') unless params[:number_night]
    return raise BadRequestError, adult_total: I18n.t('models.can_not_blank') unless params[:adult_total]
    return raise BadRequestError, person_total: I18n.t('models.can_not_blank') unless params[:person_total]
    return raise BadRequestError, childrens: I18n.t('models.can_not_blank') unless params[:childrens]
    return raise BadRequestError, total_room: I18n.t('models.can_not_blank') unless params[:total_room]
  end

  def create_order_accompany!
    HotelContracts::OrderAccompanyContracts::Create.new(order_accompany_params[:order_accompanies]).valid!
    Hotel::OrderAccompany.create!(order_accompany_params[:order_accompanies])
  end

  def create_hotel_order(order_accompany, room_price, option_price, children_price, sale_off_price, amount_price) # rubocop:disable Metrics/ParameterLists
    order_no = generate_code(Hotel::Order.name)
    order_params = hotel_order_params.merge(
      order_no:                  order_no,
      user_id:                   params[:user_id],
      hotel_plan_id:             plan.id,
      hotel_room_id:             room.id,
      number_night:              number_night,
      hotel_order_accompany_id:  order_accompany.id,
      total:                     amount_price,
      tax_service:               hotel.tax_service,
      price_room:                room_price,
      price_option:              option_price,
      price_sale_off_stay_night: sale_off_price,
      price_children:            children_price,
    )
    HotelContracts::OrderContracts::Create.new(order_params).valid!
    hotel.hotel_orders.create!(order_params)
  end

  def create_order_log!(hotel_order)
    order_log_params = {
      hotel:              hotel_order.hotel,
      plan:               hotel_order.hotel_plan,
      room:               hotel_order.hotel_room,
      hotel_order_info:   hotel_order,
      hotel_order_params: log_params,
    }
    HotelContracts::OrderLogContracts::Create.new(order_log_params).valid!
    hotel_order.create_hotel_order_log!(order_log_params)
  end

  def use_point(hotel_order)
    return if !params[:used_points] || !params[:user_id]

    used_point = params[:used_points].to_i
    user_point_bonus = user.point_bonus
    create_point_usages(user, hotel_order, used_point)
    if user_point_bonus > used_point
      user.decrement!(:point_bonus, used_point)
    else
      user.decrement!(:point_bonus, user_point_bonus)
      user.decrement!(:point, used_point - user_point_bonus)
    end
  end

  def create_point_bonus(hotel_order)
    point_normal(hotel_order)
    point_bonus(hotel_order)
  end

  def point_normal(object)
    return unless plan.point_receive && user

    percent = plan.point_receive
    used_point = params[:used_points].to_i
    received_point = ((object.total + used_point) * (percent.to_f / 100)).round
    user.point_usages.create!(
      module:         object,
      received_point: received_point,
      type_point:     PointUsage::NORMAL,
      start_date:     date_check_out + 10,
      end_date:       Time.now.since(plan.exp_point_receive.month),
    )
  end

  def point_bonus(object)
    return unless plan.point_bonus && user

    percent = plan.point_bonus
    used_point = params[:used_points].to_i
    received_point = ((object.total + used_point) * (percent.to_f / 100)).round
    user.point_usages.create!(
      module:         object,
      received_point: received_point,
      type_point:     PointUsage::BONUS,
      start_date:     date_check_out + 10,
      end_date:       Time.now.since(plan.exp_point_bonus.month),
    )
  end

  def total_amount_price(room_price, option_price, children_price, sale_off_price)
    total = room_price + option_price + children_price - sale_off_price
    total_price = if params[:used_points]
                    total - hotel_order_params[:used_points]
                  else
                    total
                  end
    return total_price unless params[:coupon_id]

    total_price - price_coupon
  end

  def price_coupon
    return 0 unless params[:coupon_id].present?

    Coupon.find(params[:coupon_id]).price&.round
  end

  def order_accompany_params
    params.permit(order_accompanies: %i[is_owner first_name last_name first_name_kana last_name_kana gender
                                        postal_code phone_number telephone address1 address2 email birth_day])
  end

  def hotel_order_params
    params.permit(:check_in, :check_out, :adult_total, :person_total, :used_points, :user_id, :total_room,
                  :coupon_id, :time_estimate, :comments, :cancellation_type, :cancellation_free,
                  :people_statistic, :registration_pattern, :registrar_name, :phone_reciprocal_time,
                  :manifest, :payment_method, :payment_status, :cancellation_other_reason, :status,
                  option_ids: [], childrens: %i[esug eslsy imba iba ima imwb])
  end

  def log_params
    params.merge(hotel_options: hotel_options, coupon: coupon)
  end

  def hotel_options
    return unless params[:option_ids]

    Hotel::Option.includes(:assets).where(id: params[:option_ids]).map do |obj|
      Api::Hotels::Options::AttributesSerializer.new(obj)
    end
  end

  def coupon
    return unless params[:coupon_id]

    Coupon.find(params[:coupon_id])
  end

  def remaining_rooms
    room_settings.each do |obj|
      if (obj.remain_room - params[:total_room].to_i).negative? || obj.remain_room <= 0
        return raise BadRequestError, remain_room: I18n.t('hotels.rooms.out_of_room'),
                                      date:        obj.date
      end

      obj.decrement!(:remain_room, params[:total_room].to_i)
      obj.increment!(:reservation_number, params[:total_room].to_i)
    end
  end
end
