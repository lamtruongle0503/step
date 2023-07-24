# frozen_string_literal: true

class Api::EcommerceOperations::CartOperations::Create < ApplicationOperation
  attr_reader :user, :order, :checkout_flg

  def initialize(actor, params)
    super
    @user = actor
    @checkout_flg = params[:checkout_flg]&.to_bool
  end

  def call
    EcommerceContracts::CartContracts::Create.new(order_params.merge(user: user)).valid!
    ActiveRecord::Base.transaction do
      create_order!
    end
    order
  end

  def create_order!
    order_waiting_with_agency = user.orders.order_waiting_with_agency(params[:agency_id]).first
    if checkout_flg
      @order = Order.create!(order_params.merge({ user: user, order_status: Order::DRAFT }))
    elsif order_waiting_with_agency.present?
      order_with_product_size =
        order_waiting_with_agency
        .order_products
        .where(product_size_id: order_params[:order_products_attributes].first[:product_size_id])
        .first
      if order_with_product_size.present?
        order_with_product_size.increment!(:number,
                                           order_params[:order_products_attributes].first[:number]&.to_i)
      else
        order_waiting_with_agency.order_products.create!(order_params[:order_products_attributes])
      end
    else
      @order = Order.create!(order_params.merge({ user: user, order_status: Order::WAITING }))
    end
  end

  def order_params
    params.permit(:agency_id, order_products_attributes: %i[number color product_size_id])
  end
end
