# frozen_string_literal: true

class Api::HotelOperations::OrderOperations::Index < ApplicationOperation
  def call
    required_params
    Hotel::Order.find_by!(order_no: params[:order_no])
  end

  private

  def required_params
    return BadRequestError, order_no: I18n.t('models.can_not_blank') unless params[:order_no]
  end
end
