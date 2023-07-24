# frozen_string_literal: true

class Admin::HotelOperations::AggregateOrderOperations::Index < ApplicationOperation
  attr_reader :orders

  def initialize(actor, params)
    super
    @q = Hotel::Order.ransack(set_param_search)
    @orders = @q.result(distinct: true).includes(:user, :coupon, :point_usages)
  end

  def call # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
    {
      credit_card_and_web:                orders.order_type_payment(type_plan[:web],
                                                                    order_status[:cancel_already],
                                                                    payment_method[:credit_card],
                                                                    payment_status[:succeeded]),
      credit_card_and_consignment:        orders.order_type_payment(type_plan[:consignment],
                                                                    order_status[:cancel_already],
                                                                    payment_method[:credit_card],
                                                                    payment_status[:succeeded]),
      credit_card_and_request:            orders.order_type_payment(type_plan[:request],
                                                                    order_status[:cancel_already],
                                                                    payment_method[:credit_card],
                                                                    payment_status[:succeeded]),
      on_spot_and_web:                    orders.order_type_payment(type_plan[:web],
                                                                    order_status[:cancel_already],
                                                                    payment_method[:on_spot],
                                                                    payment_status[:succeeded]),
      on_spot_and_request:                orders.order_type_payment(type_plan[:consignment],
                                                                    order_status[:cancel_already],
                                                                    payment_method[:on_spot],
                                                                    payment_status[:succeeded]),
      on_spot_and_consignment:            orders.order_type_payment(type_plan[:request],
                                                                    order_status[:cancel_already],
                                                                    payment_method[:on_spot],
                                                                    payment_status[:succeeded]),

      cancel_credit_card_and_web:         orders.cancel_order_type_payment(type_plan[:web],
                                                                           order_status[:cancel_already],
                                                                           payment_method[:credit_card]),
      cancel_credit_card_and_consignment: orders.cancel_order_type_payment(type_plan[:consignment],
                                                                           order_status[:cancel_already],
                                                                           payment_method[:credit_card]),
      cancel_credit_card_and_request:     orders.cancel_order_type_payment(type_plan[:request],
                                                                           order_status[:cancel_already],
                                                                           payment_method[:credit_card]),
      cancel_on_spot_and_web:             orders.cancel_order_type_payment(type_plan[:web],
                                                                           order_status[:cancel_already],
                                                                           payment_method[:on_spot]),
      cancel_on_spot_and_request:         orders.cancel_order_type_payment(type_plan[:consignment],
                                                                           order_status[:cancel_already],
                                                                           payment_method[:on_spot]),
      cancel_on_spot_and_consignment:     orders.cancel_order_type_payment(type_plan[:request],
                                                                           order_status[:cancel_already],
                                                                           payment_method[:on_spot]),
    }
  end

  private

  def type_plan
    {
      web:         Hotel::Plan.type_plans[:buy], # value = 0
      consignment: Hotel::Plan.type_plans[:consignment], # value = 1
      request:     Hotel::Plan.type_plans[:request], # value = 2
    }
  end

  def order_status
    {
      requesting:          Hotel::Order.statuses[:requesting], # value = 0
      confirming_customer: Hotel::Order.statuses[:confirming_customer], # value = 1
      reserve:             Hotel::Order.statuses[:reserve], # value = 2
      stayed:              Hotel::Order.statuses[:stayed],  # value = 3
      cancel_already:      Hotel::Order.statuses[:cancel_already], # value = 4
    }
  end

  def payment_method
    {
      credit_card: Hotel::Order.payment_methods[:credit_card], # value = 0
      on_spot:     Hotel::Order.payment_methods[:on_spot], # value = 1
    }
  end

  def payment_status
    {
      pending:   Hotel::Order.payment_statuses[:pending], # value = 0
      succeeded: Hotel::Order.payment_statuses[:succeeded], # value = 1
      failed:    Hotel::Order.payment_statuses[:failed], # value = 2
      refunded:  Hotel::Order.payment_statuses[:refunded],  # value = 3
    }
  end

  def set_param_search
    params[:q] ||= {}
    if params[:date].present?
      q_date = params[:date].to_date
      params[:q][:order_in_year_eq] = q_date.year
      params[:q][:order_in_month_eq] = q_date.month
    end
    params[:q]
  end
end
