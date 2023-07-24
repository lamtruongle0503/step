# frozen_string_literal: true

class Admin::EcommerceOperations::ProductOperations::Create < ApplicationOperation
  def call
    authorize nil, Ecommerces::ProductPolicy

    ActiveRecord::Base.transaction do
      product = create_product!
      coupon = create_coupon!(product)
      create_coupon_product(product, coupon)
      upload_product(product)
      upload_coupon(coupon)
    end
  end

  private

  def create_product!
    EcommerceContracts::ProductContracts::Create.new(products_params).valid!
    Product.create!(products_params)
  end

  def create_coupon!(product)
    return if params[:coupon_attributes].blank?

    EcommerceContracts::ProductContracts::CouponContracts::Create.new(
      coupon_params.merge(product: product),
    ).valid!
    Coupon.create!(coupon_params)
  end

  def create_coupon_product(product, coupon)
    return unless coupon.present?

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

  def coupon_params
    params.require(:coupon_attributes).permit(%i[start_time end_time price])
  end

  def products_params
    params.permit(:category_id, :code, :name, :description,
                  :discount, :is_discount, :colors, :is_delivery_free,
                  :remaining_count, :description_info, :brand, :original_country, :distributor,
                  :precaution, :desired_delivery_date, :hash_tag, :is_show, :exp_date, :is_limit,
                  :is_desired_date_free, :is_desired_time_free, :is_color, :is_product_size,
                  :tax, :shipping_memo, :shipping_others, :agency_id, :option_name,
                  :point_bonus, :point_start_date, :point_end_date, :option_color_name,
                  :delivery_charges_fee, :is_delivery_charges,
                  product_sizes_attributes:          %i[
                    name price remaining_count is_limit is_color_name is_product_size
                    option_color_name color_name option_size_name
                  ],
                  delivery_time_settings_attributes: %i[
                    start_time end_time
                  ],
                  product_area_settings_attributes:  %i[
                    area_setting_id price
                  ])
  end
end
