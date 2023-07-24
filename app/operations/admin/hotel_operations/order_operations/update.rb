# frozen_string_literal: true

class Admin::HotelOperations::OrderOperations::Update < ApplicationOperation
  attr_reader :hotel_order

  def initialize(actor, params)
    super
    @hotel_order = Hotel::Order.find(params[:id])
    check_status_order_not_cancel
  end

  def call
    authorize nil, Hotel::OrderPolicy

    HotelContracts::OrderContracts::Update.new(order_params).valid!
    ActiveRecord::Base.transaction do
      @cancellation_fee = cacl_price_cancellation_policy
      @hotel_order.update!(order_params.merge(date_cancel: Time.current, cancellation_fee: @cancellation_fee))
      revert_number_room
      refund_purchased_amount(@cancellation_fee) if hotel_order.payment_method == Hotel::Order::CREDIT_CARD
      send_mail_cancel(@hotel_order)
    end
  end

  private

  def order_params
    params.permit(:status, :cancellation_type, :cancellation_other_reason, :date_cancel,
                  :cancellation_free, :payment_status)
  end

  def revert_number_room
    date_check_in = hotel_order.check_in.to_date
    date_check_out = date_check_in + hotel_order.number_night - 1
    hotel_plan = hotel_order.hotel_plan
    room_settings = hotel_plan.hotel_room_settings.date_order(hotel_order.hotel_room_id, date_check_in,
                                                              date_check_out)
    room_settings.each do |obj|
      obj.increment!(:remain_room, hotel_order.total_room)
    end
  end

  def cacl_price_cancellation_policy # rubocop:disable Metrics/AbcSize, Metrics/PerceivedComplexity
    if order_params[:cancellation_free] ||
       (hotel_order.cancellation_free.present? && hotel_order.cancellation_free)
      return 0
    end
    return hotel_order.total if Date.today > hotel_order.check_in.to_date

    hotel_cancellation_policy = hotel_order.hotel_plan.hotel_cancellation_policy
    hotel_cancellation_details = hotel_cancellation_policy.hotel_cancellation_details
    number_date_cancel = (hotel_order.check_in.to_date - Date.today).to_i
    details = hotel_cancellation_details.select { |obj| number_date_cancel.between?(obj.flg1, obj.flg2) }
    return 0 unless details.present?

    if details.first.unit == Hotel::CancellationDetail::PRECENT
      (hotel_order.total * (details.first.value / 100))&.round
    else
      details.first.value&.round
    end
  end

  def refund_purchased_amount(price_cancellation)
    purchased_id = hotel_order.purchased_id
    return unless purchased_id

    amount_refund = hotel_order.total - price_cancellation
    refund = StripeService.refund_booking(purchased_id, 'requested_by_customer', amount_refund)
    if refund.status == Order::SUCCEEDED
      hotel_order.update!(payment_status: Order::REFUNED)
    else
      hotel_order.update!(payment_status: Order::PENDING)
    end
  end

  def check_status_order_not_cancel
    return unless hotel_order.status == Hotel::Order::CANCEL_ALREADY

    raise BadRequestError, hotel_order: I18n.t('models.does_not_exists')
  end
end
