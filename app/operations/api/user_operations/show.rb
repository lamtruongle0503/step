# frozen_string_literal: true

class Api::UserOperations::Show < ApplicationOperation
  attr_reader :user

  def initialize(actor, params)
    super
    params[:id] ||= actor.id
    @user = User.find(params[:id])
  end

  def call
    customer_id = user.credit&.customer_id
    if customer_id
      credits_card = StripeService.get_list_credit_card(customer_id)
      default_card = StripeService.get_default_credit(customer_id)
    end
    { user: user, credits_card: credits_card&.push({ default_card: default_card }) }
  end
end
