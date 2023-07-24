# frozen_string_literal: true

class Admin::EcommerceOperations::ProductOperations::ShippingOperations::Index < ApplicationOperation
  attr_reader :product_size, :product, :agency

  def initialize(actor, params)
    super
    @product_size = ProductSize.find(params[:product_size_id])
    @product      = product_size.product
    @agency       = product.agency
  end

  def call
    # if agency.is_free && cal_purchased_amount(product_size, product).to_f > agency.fee_shipping.to_f
    #   delivery_amount = 0
    # else
    delivery_amount = cal_product_fee_ship(product).to_f.to_i
    # end
    { delivery_amount: delivery_amount }
  end

  def cal_purchased_amount(product_size, product)
    discount = product.discount
    tax      = product.tax

    price_with_tax     = product_size.price + (product_size.price * tax / 100)
    product_unit_price = if product.is_discount
                           price_with_tax.discount_of(discount)
                         else
                           price_with_tax
                         end
    product_unit_price * params[:number].to_i
  end

  def cal_product_fee_ship(product)
    return if product.is_delivery_free

    find_shipping_fee(product, params[:postcode]) if ZipCodeJp.find(params[:postcode])
  end
end
