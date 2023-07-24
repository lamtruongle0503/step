# frozen_string_literal: true

class Api::EcommerceOperations::OrderOperations::Create < ApplicationOperation
  attr_reader :order, :product, :coupon

  def initialize(actor, params)
    super
    @coupon = Coupon.find(params[:coupon_id]) if params[:coupon_id]
  end

  def call
    EcommerceContracts::OrderContracts::Create.new(order_params
                                              .merge(is_apply_point: params[:is_apply_point],
                                                     coupon_id:      params[:coupon_id]))
                                              .valid!
    ActiveRecord::Base.transaction do
      @order = create_order!
      @product = order.order_product.product_size.product
      update_remaining_product!(product)
      create_coupon_order!(order, coupon)
      update_purchased_amount!(order, product)
      payment_amount(actor, order)
    end
    order.reload
  end

  private

  def create_order!
    Order.create!(order_params.merge(checkout_date: Time.zone.now))
  end

  def order_params
    params.permit(
      :payment_type,
      order_product_attributes: %i[
        number color product_size_id discount
      ],
      order_info_attributes:    %i[
        delivery_date
        delivery_start_time
        delivery_end_time
        content
        address_id
      ],
    ).merge(code:         generate_code(Order.name),
            order_status: Order::INPROGRESS,
            user:         actor)
  end
end
