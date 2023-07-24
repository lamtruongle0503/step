# frozen_string_literal: true

class Api::EcommerceOperations::ProductOperations::Index < ApplicationOperation
  attr_reader :sort_price_desc, :sort_price_asc, :sort_newest

  def initialize(actor, params)
    super
    @sort_price_desc = params[:sort_price_desc]&.to_bool
    @sort_price_asc  = params[:sort_price_asc]&.to_bool
    @sort_newest     = params[:sort_newest]&.to_bool
  end

  def call
    @q        = Product.preload(:product_sizes).includes(:category, :assets)
                       .show
                       .order_price_desc(sort_price_desc)
                       .order_price_asc(sort_price_asc)
                       .order_newest(sort_newest)
                       .ransack(params[:q])
    @products = @q.result.page(params[:page]).per(params[:per_page])
  end
end
