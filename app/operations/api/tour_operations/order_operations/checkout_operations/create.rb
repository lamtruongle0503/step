# frozen_string_literal: true

class Api::TourOperations::OrderOperations::CheckoutOperations::Create < ApplicationOperation
  attr_reader :order, :user

  def initialize(actor, params)
    super
    @user     = actor
    @order    = user.tour_orders.includes(:tour).find(params[:order_id])
  end

  def call
    ActiveRecord::Base.transaction do
      update_order!(order)
      payment!(user, order)
    end
  end

  private

  def update_order!(order)
    TourContracts::OrderContracts::CheckoutContracts::Create.new(tour_order_params).valid!
    order.update!(
      payment_method: params[:payment_method],
    )
  end

  def payment!(user, order)
    return unless order.payment_method == Tour::Order::CREDIT_CARD

    customer_id = user.credit.customer_id
    description = "user: #{user.phone_number} purchased tour_order_no: #{order.order_no}"
    order_status = payment_tour(customer_id, order.total.round, description, params[:card_id])
    order.update!(
      payment_status: order_status[:status],
      purchased_id:   order_status[:id],
      status:         Tour::Order::BOOKED,
    )
  end

  def tour_order_params
    {}.tap do |order_params|
      order_params[:record]         = order
      order_params[:user]           = actor
      order_params[:payment_method] = params[:payment_method]
    end
  end
end
