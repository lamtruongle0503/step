# frozen_string_literal: true

class Api::EcommerceOperations::OrderOperations::ReceiptionOperations::Update < ApplicationOperation
  attr_reader :order

  def initialize(actor, params)
    super
    @order = Order.find(params[:order_id])
  end

  def call
    if params[:email].present?
      order.order_info.update!(email_receiption: params[:email])

      client = AwsSqsService.new

      title = "【STEP TRAVEL 通販サービス】#{order.code}"

      body =  ApplicationController.render template: 'ecommerces/receiptions/pdf',
                                           layout:   'ecommerces/receiption_pdf',
                                           locals:   { order: order }

      client.send('EMAIL', title, body, params[:email])
    else
      order.order_info.update!(buy_name: params[:buy_name])
    end
  end
end
