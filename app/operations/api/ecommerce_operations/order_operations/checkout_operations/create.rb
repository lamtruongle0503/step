# frozen_string_literal: true

class Api::EcommerceOperations::OrderOperations::CheckoutOperations::Create < ApplicationOperation
  attr_reader :order, :product, :coupon, :payment, :delivery, :address, :user

  def initialize(actor, params)
    super
    @order    = Order.includes(order_products: %i[product product_size]).find(params[:order_id])
    @payment  = Payment.find(params[:payment_id])
    @delivery = Delivery.find(params[:delivery_id])
    @address  = Address.find(params[:address_id]) if params[:address_id]
    @coupon   = Coupon.find(params[:coupon_id]) if params[:coupon_id]
    @user     = actor
  end

  def call # rubocop:disable Metrics/AbcSize
    ActiveRecord::Base.transaction do
      create_order_info!(user, order, order_info_params)
      update_order!
      create_coupon_order!(order, coupon)
      update_remaining_product!(order)
      earn_normal_point(order, coupon, params[:is_apply_point])
      earn_bonus_point(order, coupon, params[:used_point].to_i, params[:is_apply_point], params[:address_id])
      create_point_usages(user, order, params[:used_point].to_i) if params[:is_apply_point]
      update_coupon_user!(user, params)
      create_order_log!(order)
      payment_order(order, params[:used_point].to_i, coupon, params[:address_id], params[:is_apply_point])
      decrement_point_used!(order, params[:used_point].to_i, coupon, params[:is_apply_point],
                            params[:address_id])
      send_mail_to_user_and_agency(order)
    end
  end

  private

  def update_order!
    EcommerceContracts::OrderContracts::CheckoutContracts::Create.new(order_params).valid!
    order.update!(code: generate_code(Order.name), order_status: Order::INPROGRESS,
                  payment_id: params[:payment_id], checkout_date: Time.zone.now,
                  delivery_id: params[:delivery_id], delivery_status: Order::NOT_DELIVERY,
                  coupon_id: params[:coupon_id])
  end

  def send_mail_to_user_and_agency(order)
    agency = order.agency

    client = AwsSqsService.new

    title = "【STEP TRAVEL 通販サービス】#{order.code}：注文を受け付けました"

    # Send mail to agency
    body = CheckoutMailer.with(order: order).mail_to_agency.body.to_s.html_safe
    client.send('EMAIL', title, body, agency.email)

    return unless order.user.email

    # Send mail to orderer
    body = CheckoutMailer.with(order: order).mail_to_user.body.to_s.html_safe
    client.send('EMAIL', title, body, order.user.email)
  end

  def order_info_params
    params.permit(%i[delivery_date delivery_start_time delivery_end_time content address_id])
  end

  def order_params
    {}.tap do |o|
      o[:record]         = order
      o[:user]           = actor
      o[:code]           = generate_code(Order.name)
      o[:is_apply_point] = params[:is_apply_point]
      o[:coupon_id]      = params[:coupon_id]
      o[:payment_id]     = params[:payment_id]
      o[:delivery_id]    = params[:delivery_id]
    end
  end
end
