# frozen_string_literal: true

class Api::CreditOperations::Create < ApplicationOperation
  attr_reader :card_number, :exp_date, :cvc_number, :customer_id, :user_name, :card

  def initialize(actor, params)
    super
    @card_number = params[:card_number]
    @exp_date    = params[:exp_date]&.to_date
    @cvc_number  = params[:cvc_number]
    @user_name   = params[:user_name]
  end

  def call
    format_params_exp_date
    CreditContracts::Create.new(credit_params).valid!
    create_card!
    { card_id: card.id }
  end

  private

  def format_params_exp_date
    params[:exp_date] = params[:exp_date]&.to_date&.end_of_month
  end

  def create_card!
    customer = Credit.find_by(user_id: actor.id)
    if customer
      @customer_id = customer.customer_id
    else
      create_customer!
    end
    @card = StripeService.create_credit_card(
      customer_id,
      user_name,
      card_number,
      exp_date.month,
      exp_date.year,
      cvc_number,
    )
  end

  def create_customer!
    @customer_id = ::StripeService.create_customer(actor).id
    Credit.create!(user_id: actor.id, customer_id: customer_id)
  end

  def credit_params
    params.permit(
      :card_number,
      :exp_date,
      :cvc_number,
      :user_name,
    )
  end
end
