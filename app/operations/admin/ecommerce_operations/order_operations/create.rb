# frozen_string_literal: true

class Admin::EcommerceOperations::OrderOperations::Create < ApplicationOperation
  attr_reader :product_size, :user, :payment, :delivery, :user_address, :product,
              :coupon, :order, :address

  def initialize(actor, params)
    super
    @product_size = ProductSize.find(params[:order_product][:product_size_id])
    @user         = User.find_by!(phone_number: params[:phone_number])
    @payment      = Payment.find(params[:payment_id])
    @delivery     = Delivery.find(params[:delivery_id])
    @user_address = Address.find(params[:user_address_id]) if params[:user_address_id].present?
    @product      = @product_size.product
    @coupon       = Coupon.find(params[:coupon_id]) if params[:coupon_id]
  end

  def call # rubocop:disable Metrics/AbcSize
    authorize nil, Ecommerces::OrderPolicy
    ActiveRecord::Base.transaction do
      @order    = create_order!
      @address  = create_user_address!
      create_order_info!(user, order, order_info_params)
      create_order_product!(order)
      create_coupon_order!(order, coupon)
      update_remaining_product!(order)
      earn_normal_point(order, coupon, params[:is_apply_point])
      earn_bonus_point(order, coupon, params[:used_point].to_i, params[:is_apply_point], params[:address_id])
      update_coupon_user!(user, params)
      create_order_log!(order)
      decrement_point_used!(order, params[:used_point].to_i, coupon, params[:is_apply_point],
                            params[:address_id])
      payment_order(order, params[:used_point].to_i, coupon, params[:user_address_id],
                    params[:is_apply_point])
    end
  end

  private

  def create_order!
    Order.create!(
      user:            user,
      payment_status:  Order::PENDING,
      delivery_status: Order::NOT_DELIVERY,
      order_status:    Order::INPROGRESS,
      checkout_date:   Time.zone.now.to_date,
      code:            generate_code(Order.name),
      agency_id:       product_size.product.agency_id,
      payment:         payment,
      delivery:        delivery,
    )
  end

  def update_order!(payment_amount, delivery_amount)
    usage_point = cal_usage_point(user, order, payment_amount, params).to_f
    purchased_amount = payment_amount - usage_point
    if order.payment.code == Order::ON_DELIVERY
      delivery_charge_fee = order.products.map(&:delivery_charges_fee).max.to_f
      order.update(delivery_charges_fee: delivery_charge_fee)
    end
    order.update(payment_status:   Order::PENDING,
                 purchased_amount: purchased_amount,
                 delivery_amount:  delivery_amount,
                 coupon_amount:    coupon&.price.to_f,
                 used_point:       usage_point)
  end

  def create_user_address!
    return if params[:user_address_id].present?

    user.addresses.create!(address_params)
  end

  def create_order_product!(order)
    order.order_products.create!(order_product_params)
  end

  def order_info_params
    params[:order_info].permit(%i[delivery_date delivery_start_time delivery_end_time content])
                       .tap do |attrs|
      attrs['address_id'] = params[:user_address_id].present? ? params[:user_address_id] : address.id
    end
  end

  def order_product_params
    params[:order_product].permit(%i[number color product_size_id])
  end

  def address_params
    params[:user_address].permit(:full_name, :postcode, :address1, :address2, :telephone)
  end
end
