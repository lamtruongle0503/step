# frozen_string_literal: true

class Api::HotelOperations::CheckoutOperations::Update < ApplicationOperation
  attr_reader :customer_id, :hotel_order

  def initialize(actor, params)
    super
    @hotel_order = Hotel::Order.find(params[:id])
    @customer_id = actor.credit&.customer_id
  end

  def call
    ActiveRecord::Base.transaction do
      description = "user: #{actor.phone_number} purchased hotel: #{hotel_order.hotel.name} order_no: #{hotel_order.order_no}"
      if customer_id
        payment = payment_hotel(customer_id, hotel_order.total.round, description,
                                params[:card_id])
        update_status_payment!(hotel_order, payment)
      end
    end
  end

  private

  def update_status_payment!(hotel_order, payment)
    hotel_order.update!(payment_status: payment[:status], purchased_id: payment.id)
  end
end
