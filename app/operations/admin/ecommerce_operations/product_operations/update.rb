# frozen_string_literal: true

class Admin::EcommerceOperations::ProductOperations::Update < ApplicationOperation
  attr_reader :product, :coupon, :agency_old

  def initialize(actor, params)
    super
    @product = Product.find(params[:id])
    @coupon = product.coupon
    @agency_old = @product.agency_id
  end

  def call
    authorize nil, Ecommerces::ProductPolicy

    ActiveRecord::Base.transaction do
      update_product!
      create_or_update_coupon
      create_coupon_product(product.reload, coupon)
      upload_product(product)
      upload_coupon(coupon)
      update_agency_order? if can_update_agency_order?
    end
  end

  private

  def can_update_agency_order?
    @agency_old.to_i != params[:agency_id].to_i
  end

  def update_product!
    EcommerceContracts::ProductContracts::Update.new(products_params.merge(product: product)).valid!
    product.update!(products_params)
  end

  def create_or_update_coupon
    return product.coupon&.destroy if params[:coupon_attributes].blank?

    if coupon.present? && not_whole_change?(coupon, coupon_params)
      EcommerceContracts::ProductContracts::CouponContracts::Update.new(
        coupon_params.merge(product: product),
      ).valid!
      coupon.update!(coupon_params)
    else
      coupon.destroy! if coupon.present?
      EcommerceContracts::ProductContracts::CouponContracts::Create.new(
        coupon_params.merge(product: product),
      ).valid!
      @coupon = Coupon.create!(coupon_params)
    end
  end

  def create_coupon_product(product, coupon)
    return if coupon.blank? || product.coupon.present?

    product.create_coupons_module!(coupon: coupon)
  end

  def upload_product(product)
    return unless params[:file].is_a? Array

    params[:file].each do |file|
      upload_multiple_file(product, file[:url], file[:type], file[:file_type])
    end
  end

  def upload_coupon(coupon)
    return unless params[:coupon_file].is_a? Array

    params[:coupon_file].each do |file|
      upload_multiple_file(coupon, file[:url], file[:type], file[:file_type])
    end
  end

  def update_agency_order?
    user_ids = Order.where(agency_id: agency_old, order_status: Order::WAITING).pluck(:user_id)
    return unless user_ids.present?

    user_ids.each do |user_id|
      order_agency_old = Order.find_by!(agency_id: agency_old, order_status: Order::WAITING, user_id: user_id)
      next unless order_agency_old.present?

      order_agency_new = Order.find_by(agency_id: product.agency_id, order_status: Order::WAITING,
                                       user_id: user_id)

      if order_agency_new.present?
        update_order_product_agency(order_agency_old, order_agency_new)
      else
        create_order_agency_new(order_agency_old)
      end
    end
  end

  def create_order_agency_new(order)
    order_new = Order.create!(agency_id: product.agency_id, user_id: order.user_id,
                              order_status: Order::WAITING)
    update_order_product_agency(order, order_new)
  end

  def update_order_product_agency(order_old, order_new)
    if order_old.order_products.present? &&
       order_old.order_products.size < 2 &&
       order_old.order_products.first.product.id == product.id
      order_old.order_products.update_all(order_id: order_new.id)
      order_old.destroy!
    else
      order_old.order_products.includes(:product).map do |obj|
        next if obj.product.id != product.id

        obj.update!(order_id: order_new.id)
      end
    end
  end

  def not_whole_change?(coupon, coupon_params)
    !(coupon.start_time != coupon_params[:start_time] &&
      coupon.end_time   != coupon_params[:end_time] &&
      coupon.price      != coupon_params[:price]
     )
  end

  def coupon_params
    params.require(:coupon_attributes).permit(%i[start_time end_time price])
  end

  def products_params
    params.permit(:category_id, :code, :name, :description,
                  :discount, :is_discount, :colors, :option_color_name,
                  :remaining_count, :description_info,
                  :brand,
                  :original_country,
                  :distributor,
                  :precaution,
                  :desired_delivery_date,
                  :hash_tag,
                  :is_show, :option_name,
                  :is_delivery_free,
                  :exp_date,
                  :is_limit,
                  :is_desired_date_free, :option_color_name,
                  :delivery_charges_fee, :is_delivery_charges,
                  :is_desired_time_free, :is_color, :is_product_size,
                  :tax, :shipping_memo, :shipping_others, :agency_id,
                  :point_bonus, :point_start_date, :point_end_date,
                  product_sizes_attributes:          %i[
                    id name price remaining_count is_limit is_color_name is_product_size
                    option_color_name color_name option_size_name _destroy
                  ],
                  delivery_time_settings_attributes: %i[
                    id start_time end_time _destroy
                  ],
                  product_area_settings_attributes:  %i[
                    id area_setting_id price
                  ])
  end
end
