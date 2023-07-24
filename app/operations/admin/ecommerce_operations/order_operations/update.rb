# frozen_string_literal: true

class Admin::EcommerceOperations::OrderOperations::Update < ApplicationOperation
  attr_reader :order

  def initialize(actor, params)
    super
    @order = Order.find(params[:id])
  end

  def call
    authorize nil, Ecommerces::OrderPolicy

    EcommerceContracts::OrderContracts::Update.new(update_params.merge!(record: order)).valid!
    ActiveRecord::Base.transaction do
      order.update!(update_params)
      update_order_info!(order)
      update_point_use_start_date!(order)
      check_send_mail_when_update_order(order, update_params)
      refund_purchased_amount(order) if params[:order_status] == Order::CANCEL
    end
  end

  def update_params
    params.permit(:order_status, :payment_status, :delivery_status, :payment_id, :delivery_code)
  end

  def order_info_params
    params[:order_info].permit(:delivery_date, :delivery_start_time, :delivery_end_time)
  end

  def update_point_use_start_date!(order)
    return unless order.payment_status == Order::SUCCEEDED &&
                  order.delivery_status == Order::DELIVERIED &&
                  order.order_status == Order::DONE

    order.point_usages.where.not(received_point: nil).update_all(
      start_date: (DateTime.current + 20.days).to_date,
    )
  end

  def update_order_info!(order)
    order_info = order.order_info
    order_info.delivery_date = order_info_params[:delivery_date].to_date
    order_info.delivery_start_time = Time.parse("#{order_info_params[:delivery_date]} #{order_info_params[:delivery_start_time]}")
    order_info.delivery_end_time = Time.parse("#{order_info_params[:delivery_date]} #{order_info_params[:delivery_end_time]}")
    order_info.save!
  end

  def refund_purchased_amount(order)
    return unless order.payment.code == Order::CREDIT_CARD && order.payment_status == Order::SUCCEEDED

    purchased_id = order.purchased_id
    refund = StripeService.refund(purchased_id, 'requested_by_customer')
    if refund.status == Order::SUCCEEDED
      order.update!(payment_status: Order::REFUNED)
    else
      order.update!(payment_status: Order::PENDING)
    end
  end

  def check_send_mail_when_update_order(order, params)
    client = AwsSqsService.new

    if [Order::BANK_TRANSFER, Order::CONVENIENCE_STORE, Order::ON_DELIVERY].include?(order.payment.code) &&
       params[:payment_status] == Order::SUCCEEDED
      title = "【STEP TRAVEL 通販サービス】#{order.code}：注文を入金済み"
      agency_body = PaymentMailer.with(order: order).mail_to_agency.body.to_s.html_safe
      client.send('EMAIL', title, agency_body, order.agency.email)
      user_body = PaymentMailer.with(order: order).mail_to_user.body.to_s.html_safe
      client.send('EMAIL', title, user_body, order.user.email)
    end

    return unless params[:delivery_status] == Order::DELIVERIED

    mail_body = DeliveryMailer.with(order: order).completed.body.to_s.html_safe
    title = "【STEP TRAVEL 通販サービス】#{order.code}：注文を配達され"
    client.send('EMAIL', title, mail_body, order.user.email)
  end
end
