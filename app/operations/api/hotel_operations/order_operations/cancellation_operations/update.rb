# frozen_string_literal: true

class Api::HotelOperations::OrderOperations::CancellationOperations::Update < ApplicationOperation
  attr_reader :history

  def initialize(actor, params)
    super
    @history = actor.hotel_orders.find(params[:id])
    check_status_order_not_cancel
  end

  def call
    ActiveRecord::Base.transaction do
      @cancellation_fee = cacl_price_cancellation_policy
      history.update!(date_cancel: Time.now, status: Hotel::Order::CANCEL_ALREADY,
                      cancellation_fee: @cancellation_fee)
      revert_number_room
      refund_purchased_amount(@cancellation_fee) if history.payment_method == Hotel::Order::CREDIT_CARD
      send_mail_cancel(history)
    end
  end

  private

  def refund_purchased_amount(price_cancellation)
    purchased_id = history.purchased_id
    return unless purchased_id

    amount_refund = history.total - price_cancellation
    refund = StripeService.refund_booking(purchased_id, 'requested_by_customer', amount_refund)
    if refund.status == Order::SUCCEEDED
      history.update!(payment_status: Order::REFUNED)
    else
      history.update!(payment_status: Order::PENDING)
    end
  end

  def revert_number_room
    date_check_in = history.check_in.to_date
    date_check_out = date_check_in + history.number_night - 1
    hotel_plan = history.hotel_plan
    room_settings = hotel_plan.hotel_room_settings.date_order(history.hotel_room_id, date_check_in,
                                                              date_check_out)
    room_settings.each do |obj|
      obj.increment!(:remain_room, history.total_room)
    end
  end

  def cacl_price_cancellation_policy
    return 0 if history.cancellation_free.present? && history.cancellation_free
    return history.total if Date.today > history.check_in.to_date

    hotel_cancellation_policy = history.hotel_plan.hotel_cancellation_policy
    hotel_cancellation_details = hotel_cancellation_policy.hotel_cancellation_details
    number_date_cancel = (Date.today - history.created_at.to_date).to_i
    details = hotel_cancellation_details.select { |obj| number_date_cancel.between?(obj.flg1, obj.flg2) }
    return 0 unless details.present?

    details.first.value&.round
  end

  def check_status_order_not_cancel
    return unless @history.status == Hotel::Order::CANCEL_ALREADY

    raise BadRequestError, hotel_order: I18n.t('models.does_not_exists')
  end
end
