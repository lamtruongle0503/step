# frozen_string_literal: true

class Api::EcommerceOperations::ProductOperations::Show < ApplicationOperation
  def call
    include_tables = [:product_sizes, :assets, :coupon,
                      { product_area_settings: :area_setting }]
    product = Product.includes(include_tables).find(params[:id])

    delivery_amount = 0

    if actor.present? && (!product.is_delivery_free && actor.addresses.any?)
      postcode = actor.default_address&.postcode
      delivery_amount = find_shipping_fee(product, postcode) if postcode && ZipCodeJp.find(postcode)
    end
    product.delivery_amount = delivery_amount.to_i
    product
  end
end
