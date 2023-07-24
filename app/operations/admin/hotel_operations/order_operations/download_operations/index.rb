# frozen_string_literal: true

class Admin::HotelOperations::OrderOperations::DownloadOperations::Index < ApplicationOperation
  attr_reader :orders, :credit_card_and_web, :credit_card_and_consignment, :credit_card_and_request,
              :on_spot_and_web, :on_spot_and_consignment, :on_spot_and_request, :cancel_credit_card_and_web,
              :cancel_credit_card_and_consignment, :cancel_credit_card_and_request

  def initialize(actor, params) # rubocop:disable Metrics/AbcSize
    super
    required_params
    @q = Hotel::Order.ransack(set_param_search)
    @orders = @q.result(distinct: true).includes(:user, :coupon)
    @credit_card_and_web = generate_data_item(false, type_plan[:web], order_status[:cancel_already],
                                              payment_method[:credit_card], payment_status[:succeeded])
    @credit_card_and_consignment = generate_data_item(false, type_plan[:consignment],
                                                      order_status[:cancel_already],
                                                      payment_method[:credit_card],
                                                      payment_status[:succeeded])
    @credit_card_and_request = generate_data_item(false, type_plan[:request], order_status[:cancel_already],
                                                  payment_method[:credit_card], payment_status[:succeeded])
    @on_spot_and_web = generate_data_item(false, type_plan[:web], order_status[:cancel_already],
                                          payment_method[:on_spot], payment_status[:succeeded])
    @on_spot_and_consignment = generate_data_item(false, type_plan[:consignment],
                                                  order_status[:cancel_already],
                                                  payment_method[:on_spot],
                                                  payment_status[:succeeded])
    @on_spot_and_request = generate_data_item(false, type_plan[:request], order_status[:cancel_already],
                                              payment_method[:on_spot], payment_status[:succeeded])
    @cancel_credit_card_and_web = generate_data_item(true, type_plan[:web], order_status[:cancel_already],
                                                     payment_method[:credit_card])
    @cancel_credit_card_and_consignment = generate_data_item(true, type_plan[:consignment],
                                                             order_status[:cancel_already],
                                                             payment_method[:credit_card])
    @cancel_credit_card_and_request = generate_data_item(true, type_plan[:request],
                                                         order_status[:cancel_already],
                                                         payment_method[:credit_card])
  end

  def call
    data = generate_data
    template = 'downloads/hotel_orders_report.html.erb'
    HtmlToPdfService.new(template, data).perform
  end

  private

  def generate_data
    date = params[:date].to_date
    {
      meta:                               {
        hotel_name:    hotel_name || '',
        month:         date.month,
        created_at:    Date.today,
        total_payment: total_payment_amount,
      },
      credit_card_and_web:                credit_card_and_web,
      credit_card_and_consignment:        credit_card_and_consignment,
      credit_card_and_request:            credit_card_and_request,
      credit_card_web_and_request:        credit_card_web_and_request,
      on_spot_and_web:                    on_spot_and_web,
      on_spot_and_request:                on_spot_and_request,
      on_spot_and_consignment:            on_spot_and_consignment,
      on_spot_use_point:                  on_spot_use_point,
      cancel_credit_card_and_web:         cancel_credit_card_and_web,
      cancel_credit_card_and_consignment: cancel_credit_card_and_consignment,
      cancel_credit_card_and_request:     cancel_credit_card_and_request,
      cancel_credit_card_web_request:     cancel_credit_card_web_request,
    }
  end

  def generate_data_item(is_cancel, type_plan, order_status, payment_method, payment_status = nil)
    data = if is_cancel
             orders.cancel_order_type_payment(type_plan, order_status, payment_method)
           else
             orders.order_type_payment(type_plan, order_status, payment_method, payment_status)
           end
    total = data.pluck(:total).sum
    rate = rate_plan(type_plan)
    commission = total * rate / 100
    deposit = payment_method == Hotel::Order.payment_methods[:on_spot] ? total : total - commission
    billing = commission if payment_method == Hotel::Order.payment_methods[:on_spot]
    {
      size:       data.size,
      total:      total,
      rate:       rate,
      commission: commission,
      deposit:    deposit,
      billing:    billing,
    }
  end

  def credit_card_web_and_request
    data = credit_card_and_web[:size] + credit_card_and_request[:size]
    total = credit_card_and_web[:total] + credit_card_and_request[:total]
    rate = 4
    commission = total * rate / 100
    billing = commission
    {
      size:       data,
      total:      total,
      rate:       rate,
      commission: commission,
      deposit:    nil,
      billing:    billing,
    }
  end

  def on_spot_use_point
    order_on_spot = orders.where("payment_method = #{payment_method[:on_spot]} AND used_points > 0")
    total = order_on_spot.sum(:used_points)
    {
      size:       order_on_spot.size,
      total:      total,
      rate:       nil,
      commission: nil,
      deposit:    total,
      billing:    nil,
    }
  end

  def cancel_credit_card_web_request
    data = cancel_credit_card_and_web[:size] + cancel_credit_card_and_request[:size]
    total = cancel_credit_card_and_web[:total] + cancel_credit_card_and_request[:total]
    rate = 4
    commission = total * rate / 100
    {
      size:       data,
      total:      total,
      rate:       rate,
      commission: commission,
      deposit:    nil,
      billing:    commission,
    }
  end

  def total_payment_amount
    credit_card_and_web[:total] + credit_card_and_consignment[:total] +
      credit_card_and_request[:total] + on_spot_and_web[:total] +
      on_spot_and_request[:total] + on_spot_and_consignment[:total]
  end

  def hotel_name
    Hotel.find(params.dig(:q, :hotel_id_eq)).name if params.dig(:q, :hotel_id_eq)
  end

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

  def required_params
    return raise BadRequestError, date: I18n.t('models.can_not_blank') unless params[:date]
  end

  def rate_plan(type)
    case type
    when 0
      8
    when 1
      30
    when 2
      13
    end
  end
end
